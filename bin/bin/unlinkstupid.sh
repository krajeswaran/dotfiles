#!/bin/sh

GIT_FOLDER_ROOT="${HOME}/src/"
GALACTICA_FOLDER="${HOME}/src/galactica"

#---------------

pushd `pwd`; cd ~ ; cd ${GALACTICA_FOLDER}
rm venv/lib/python2.7/site-packages/accounts 
rm venv/lib/python2.7/site-packages/payments_ui 
rm venv/lib/python2.7/site-packages/reporting_ui

mv venv/lib/python2.7/site-packages/accounts_orig venv/lib/python2.7/site-packages/accounts
mv venv/lib/python2.7/site-packages/payments_ui_orig venv/lib/python2.7/site-packages/payments_ui
mv venv/lib/python2.7/site-packages/reporting_ui_orig venv/lib/python2.7/site-packages/reporting_ui

echo 'UNlinkified.'
