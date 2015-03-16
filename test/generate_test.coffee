require 'mocha-cakes'
faker = require 'faker'
assert = require 'assert'
htpass = require '../src/generate'

Feature 'Test generate htpassd password', ->

  Scenario 'Generate password for dummy user', ->

    user = null
    password = '123456'
    hashedLine = null

    Given 'Generate user', ->
      user = faker.name.firstName().toLowerCase()

    And 'and generate password', ->
      hashedLine = htpass.generate_htpasswd user, password

    Then 'Check password', ->
      assert.ok htpass.verify_password(user, password, hashedLine.split(":")[1])
