# Sinopia utils

[![npm version](https://badge.fury.io/js/sinopia-htaccess-gpg-email.svg)](https://badge.fury.io/js/sinopia-htaccess-gpg-email) [![Build Status](https://github.com/abtris/sinopia-htaccess-gpg-email/actions/workflows/node.js.yml/badge.svg)](https://github.com/abtris/sinopia-htaccess-gpg-email/actions)
[![Dependabot Status](https://api.dependabot.com/badges/status?host=github&repo=abtris/sinopia-htaccess-gpg-email)](https://dependabot.com)


Generate password in [htaccess format](https://httpd.apache.org/docs/2.4/howto/htaccess.html).

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
