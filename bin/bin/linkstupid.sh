#!/bin/sh

GIT_FOLDER_ROOT="${HOME}/src/"
GALACTICA_FOLDER="${HOME}/src/galactica"

#---------------

pushd `pwd`; cd ~ ; cd ${GALACTICA_FOLDER}
mv venv/lib/python2.7/site-packages/accounts venv/lib/python2.7/site-packages/accounts_orig
mv venv/lib/python2.7/site-packages/payments_ui venv/lib/python2.7/site-packages/payments_ui_orig
mv venv/lib/python2.7/site-packages/reporting_ui venv/lib/python2.7/site-packages/reporting_ui_orig

ln -s ${GIT_FOLDER_ROOT}/django-accounts/accounts venv/lib/python2.7/site-packages/
ln -s ${GIT_FOLDER_ROOT}/django-payments-ui/payments_ui venv/lib/python2.7/site-packages/
ln -s ${GIT_FOLDER_ROOT}/django-reporting-ui/reporting_ui venv/lib/python2.7/site-packages/

echo 'Linkified.'
