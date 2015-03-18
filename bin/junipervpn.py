#!/usr/bin/env python
import urllib
import os
import stat
import sys
from urlparse import urlparse
import subprocess
import shlex
import ConfigParser
import argparse
import logging
import mechanize

class JuniperVPN:
    """A script to help with Juniper VPN connections on 64-bit linux.

    As prerequistes for executing this script, it is required that the Juniper
    software has been downloaded to your computer.  (See
    http://mad-scientist.us/juniper.html for instructions.)  Next, leveraging
    the work of sdeming, you will need to create an 'ncui' executable from the
    ncui.so, and additionally retrieve the SSL certificate from your
    companies' website.  The instructions are available here:
    http://makefile.com/.plan/2009/10/27/juniper-vpn-64-bit-linux-an-unsolved-mystery
    Once those steps are complete, this script will automatically log you in,
    retrieve the DSID cookie, and call the 'ncui' executable.

    The first time the script is executed, you will want to use the '-c'
    option to create a new configuration file.

    And this script is customised to work with rex.corp.ebay.com's infinite redirections
    and bizzare quirks - like a challenge page that asks you to "continue the session"(cancelling
    will throw you out!). And also note that I have removed two-factor authentication stuff from
    this script - rex.corp.ebay.com doesn't reallly use it right now.

    Note:

        This script assumes many things about the method for logging in.
        Read instructions in the README.md file to setup properly.

    """

    def __init__(self):
        # Configuration file
        self.config = os.path.expanduser("~/.junipervpn")
        self.section = "junipervpn"

        # log file
        self.logFile = "~/.junipervpn.log"
        logging.basicConfig(filename=os.path.expanduser(self.logFile),
                            level=logging.DEBUG,
                            filemode="w")
        logging.basicConfig(format='%(asctime)s %(levelname)s: %(message)s',
                            datefmt='%m/%d/%Y %I:%M:%S %p')


        # Configuration options
        parser = argparse.ArgumentParser(description='64-bit Linux Juniper VPN authentication automation.')
        parser.add_argument("-c", "--create", action="store_true",
                            help='create a new config file.')
        args = parser.parse_args()
        create = vars(args)["create"]

        # If we're commanded to create a new config file, remove one that may exist
        if(create==True):
            logging.debug("Creation of new configuration file requested.")
            self.removeConfig()
            self.createConfig()
            sys.exit()

        # Now create & read
        if (os.path.exists(self.config)):
            self.readConfig()
        else:
            sys.exit("Configuration file ('%s') not found." % self.config)

        # Verify these files exist
        if (os.path.isfile(os.path.expanduser(self.ncui)) == False):
            logging.debug("ncui exec ('%s') not found." % self.ncui)
            sys.exit("Unable to find ncui executable.")
        if (os.path.isfile(os.path.expanduser(self.cert)) == False):
            logging.debug("ssl cert ('%s') not found." % self.cert)
            sys.exit("Unable to find SSL certificate.")

        self.host = urlparse(self.url).netloc

    def getUserInfo(self):
        """Prompts the user for their token"""
        print "Preparing to login."
        # Now it will prompt the user for the SecurID token
        self.pintoken = self.pin + raw_input("Token:  ")

    def login(self):
        """Attempts to login with the provided credentials."""
        loginData = urllib.urlencode({'username'  : self.username,
                                      'password'  : self.pintoken,
                                      'realm'     : self.realm,
                                      'btnSubmit' : 'Sign In',
                                      'tz_offset'  : '330'})
        self.cj = mechanize.CookieJar()
        self.browser = mechanize.Browser()
        # ignore robots.txt, I don't have a conscience after all ;)
        self.browser.set_handle_robots(False)
        # set these values to true and uncomment if you want to debug what's going on
        #self.browser.set_debug_http(True)
        #self.browser.set_debug_responses(True)
        #self.browser.set_debug_redirects(True)
        #logger = logging.getLogger()
        #logger.addHandler(logging.StreamHandler(sys.stdout))
        #logger.setLevel(logging.DEBUG)
        # emulate google chrome on linux
        self.browser.addheaders = [('User-agent', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/536.5 (KHTML, like Gecko) Chrome/19.0.1084.1 Safari/536.5')]
        # step.1 hit the homepage to get some cookies
        first_request = mechanize.Request(self.welcome_page_url)
        first_response = mechanize.urlopen(first_request)
        self.cj.extract_cookies(first_response, first_request)
        self.browser.set_cookiejar(self.cj)
        # step.2 now we are submitting the form with username and pin
        self.browser.open(self.url, loginData)
        # step.3 let's see if we encounterd "continue the session" challenge
        try:
            # debug for all forms
            #for f in self.browser.forms():
            #    print f
            #    for control in f.controls:
            #        control.disabled = False
            #        print "type=%s, name=%s" % (control.type, control.name)
            #        print control.value
            self.browser.select_form('frmConfirmation')
            self.browser.form.set_all_readonly(False)
        except mechanize.FormNotFoundError:
            logging.debug("No continue session challenge encountered")
        except mechanize.ControlNotFoundError:
            logging.debug("No multiple checkboxes found")
        else:
            self.browser.form.find_control(type='checkbox', nr=0).items[0].selected = True
            self.browser.form['btnContinue']
            self.browser.form.new_control('text', 'postfixSID', {'value':''})
            self.browser.form.fixup()
            self.browser.submit()
        logging.debug("Logging into %s..." % self.url)

    def getDSIDValue(self):
        """Retrieves the value of the DSID cookie."""
        for c in self.cj:
            if c.name == "DSID":
                logging.debug("Successfully retrieved DSID cookie: ('%s')" % c.value)
                return c.value
        logging.debug("Login to '%s' failed; no DSID cookie found." % self.url)
        sys.exit("Login failed, no DSID cookie found.")

    def startVPN(self):
        """Calls the executable with the appropriate options."""
        cmd = '%s -h %s -c DSID=%s -f %s' % (os.path.expanduser(self.ncui),
                                             self.host,
                                             self.getDSIDValue(),
                                             os.path.expanduser(self.cert))
        print "Starting VPN connection..."
        logging.debug("Calling ncui exec with: %s" % cmd)
        cmd = shlex.split(cmd)
        self.p = subprocess.Popen(cmd, stdin=subprocess.PIPE)
        # When launched, there will be a prompt for a Password.
        # which should be safely ignored
        self.p.communicate("\n")

    def createConfig(self):
        """Creates a configuration file if none is found."""
        print "Creating new configuration file."
        logging.debug("Creating new config file: ('%s')" % self.config)
        # Prompt for input
        user = raw_input("Username:  ")
        pin  = raw_input("PIN:  ")

        # defaults for the program / certificate
        ncuiDefault = "~/.juniper_networks/network_connect/ncui"
        certDefault = "~/.juniper_networks/network_connect/ssl.crt"
        prompt = "ncui:  (%s):  " % ncuiDefault
        ncui = raw_input(prompt).strip()
        if (ncui == ""):
            ncui = ncuiDefault
        prompt = "cert:  (%s):  " % certDefault
        cert = raw_input(prompt).strip()
        if (cert == ""):
            cert = certDefault

        # The URl of the page you'd login to
        url = raw_input("Login Page URL:  ").strip()
        welcome_page_url = raw_input("Welcome Page URL:  ").strip()
        logout_page_url = raw_input("Logout Page URL:  ").strip()
        realmDefault = "SecurID"
        prompt = "Realm:  (%s):  " % realmDefault
        realm = raw_input(prompt).strip()
        if (realm == ""):
            realm = realmDefault

        # Create the config object
        config = ConfigParser.RawConfigParser()
        config.add_section(self.section)
        config.set(self.section, "username", user)
        config.set(self.section, "pin", pin)
        config.set(self.section, "ncui", ncui)
        config.set(self.section, "cert", cert)
        config.set(self.section, "url", url)
        config.set(self.section, "welcome_page_url", welcome_page_url)
        config.set(self.section, "logout_page_url", logout_page_url)
        config.set(self.section, "realm", realm)

        # Write out the config file
        with open(self.config, 'wb') as configfile:
            config.write(configfile)
        logging.debug("Successfully wrote configuration file.")
        # As this config file contains personal info, chmod 600 it.
        os.chmod(self.config, stat.S_IRUSR | stat.S_IWUSR)

        print "Config file written to %s!\n" % self.config

    def readConfig(self):
        """Reads in the config file and sets the instance vars."""
        logging.debug("Reading configuration file.")
        config = ConfigParser.RawConfigParser()
        config.read(self.config)
        self.username = config.get(self.section, "username")
        self.pin = config.get(self.section, "pin")
        self.ncui = config.get(self.section, "ncui")
        self.cert = config.get(self.section, "cert")
        self.url = config.get(self.section, "url")
        self.welcome_page_url = config.get(self.section, "welcome_page_url")
        self.logout_page_url = config.get(self.section, "logout_page_url")
        self.realm = config.get(self.section, "realm")

    def removeConfig(self):
        """Attempts to remove a pre-existing config file."""
        if(os.path.exists(self.config)):
            logging.debug("Removing configuration file.")
            os.remove(self.config)
        else:
            logging.debug("Configuration file doesn't exist, cannot remove.")

    def stopVPN(self):
        """Stops the VPN connection."""
        print "\nStopping VPN connection..."
        try:
            logout_req = mechanize.Request(self.logout_page_url)
            self.browser.open(logout_req)
            self.p.terminate()
        except:
            print "Error with logging out of vpn or NCUI process wasn't running."

    def run(self):
        """Handles the thread of execution."""
        self.getUserInfo()
        self.login()
        self.startVPN()

    def stop(self):
        """Ends the vpn session."""
        self.stopVPN()

if __name__ == "__main__":
    vpn = JuniperVPN()
    try:
        vpn.run()
    except KeyboardInterrupt:
        print "User interrupt, stopping VPN"
        vpn.stop()
    else:
        vpn.stop()
