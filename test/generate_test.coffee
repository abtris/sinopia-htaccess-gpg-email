require 'mocha-cakes'
faker = require 'faker'
htpass = require '../src/generate'

Feature 'Test generate htpassd password', ->

  Scenario 'Generate password for dummy user', ->

    user = null
    hashedPassword = null

    Given 'Generate user', ->
      user = faker.name.firstName().toLowerCase()

    And 'and generate password', ->
      hashedPassword = htpass.generate_htpasswd(user, '123456')

    Then 'Check password', ->
      hashedPassword.should.eql "#{user}:$63FxIFcQfKek"
