# Sinopia utils [![Build Status](https://travis-ci.org/abtris/sinopia-htaccess-gpg-email.svg?branch=master)](https://travis-ci.org/abtris/sinopia-htaccess-gpg-email)

Generate password in htaccess format, encrypt with GPG and send via MailGun API to users.


## Test user for GPG

    Name: Test Test
    email: example@test.com
    password: 123456

## Usage

Create CSV file with emails and url to public keys as

    user@company.com;http://company.com/security/public-gpg/user.asc


Use [MailGun](http://www.mailgun.com/) API to send email in GPG with password to Sinopia.

    export MAILGUN_API_KEY=XXXXX
    export MAILGUN_DOMAIN=XXXXX

    send-gpg-email INPUT_FILE_WITH_EMAILS PATH_TO_SINOPIA_HTACCESS_FILE
