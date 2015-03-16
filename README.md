# Sinopia utils [![Build Status](https://travis-ci.org/abtris/sinopia-htaccess-gpg-email.svg?branch=master)](https://travis-ci.org/abtris/sinopia-htaccess-gpg-email)

Generate password in htaccess format, encrypt with GPG and send via SendGrid API to users.


## Test user for GPG

Name: Test Test
email: example@test.com
password: 123456

## Usage

Use [SendGrid](https://sendgrid.com/docs/Code_Examples/nodejs.html) API to send email in GPG with password to Sinopia.

  export SENDGRID_API_USER=XXXXX
  export SENDGRIND_API_KEY=XXXX

  send-gpg-email INPUT_FILE_WITH_EMAILS PATH_TO_SINOPIA_HTACCESS_FILE
