#!/usr/bin/env ruby

require 'watir-webdriver'

loop do
  browser = Watir::Browser.new :firefox
  browser.goto "172.16.10.1"
  browser.text_field(:name => 'usrname').set("username")
  browser.text_field(:name => 'pass').set("password")
  browser.button(:name => 'commit').click
  sleep 120
  browser.close

  sleep 180
end
