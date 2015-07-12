#!/usr/bin/env python
import mechanize
import logging
import os
import sys
from urlparse import urlparse

class RedirectCaught(Exception):
    def __init__(self, value):
        self.host = value

def ping_google(b):
    res = b.open("http://www.google.com")
    if not "Google" in b.title():
        logging.debug("google ping response %s" % res.read())
        host = urlparse(res.geturl()).netloc
        raise RedirectCaught(host)

def post_password(b, host):
    res = b.open("http://"+host+"/userportal/login.do")
    logging.debug("host login response %s" % res.read())
    b.select_form(nr=0)
    b.form['username'] = "username"
    b.form['password'] = "password"
    #b.form['type'] = ["2"]
    b.form['rememberme'] = ["on"]
    res = b.submit()
    logging.debug("host login response %s" % res.read())

if __name__ == "__main__":
    browser = mechanize.Browser()
    browser.set_handle_robots(False)

    logging.basicConfig(filename=os.path.expanduser("~/cplogin.log"),
            #level=logging.DEBUG, #uncomment to debug
            level=logging.INFO,
            filemode="w")
    logging.basicConfig(format='%(asctime)s %(levelname)s: %(message)s', 
            datefmt='%m/%d/%Y %I:%M:%S %p')

    # uncomment to turn on debug
    #browser.set_debug_http(True)
    #browser.set_debug_responses(True)
    #browser.set_debug_redirects(True)
    #logger = logging.getLogger()
    #logger.addHandler(logging.StreamHandler(sys.stdout))
    #logger.setLevel(logging.DEBUG)

    try:
        ping_google(browser)
    except RedirectCaught as r:
        logging.info("Redirect detected...")
        post_password(browser, r.host)
