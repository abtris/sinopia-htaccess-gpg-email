# Sinopia utils [![Build Status](https://travis-ci.org/abtris/sinopia-htaccess-gpg-email.svg?branch=master)](https://travis-ci.org/abtris/sinopia-htaccess-gpg-email)

[![npm version](https://badge.fury.io/js/sinopia-htaccess-gpg-email.svg)](https://badge.fury.io/js/sinopia-htaccess-gpg-email)

Generate password in htaccess format.

## Test user for GPG

    Name: Test Test
    email: example@test.com
    password: 123456

## Usage

Create CSV file with emails:

```
user@company.com;http://company.com/security/public-gpg/user.asc
```

run generate command:

```
./bin/send-gpg-email generate -i INPUT_FILE_WITH_EMAILS
```
