require 'mocha-cakes'
faker = require 'faker'
assert = require 'assert'
htpass = require '../src/generate'
inputFile = require '../src/input_file'

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

  Scenario 'Generate dummy password', ->

    pass1 = null
    pass2 = null
    pass3 = null

    Given 'Generate random password 1', ->
      pass1 = htpass.randomPassword()

    And 'and generate password 2', ->
      pass2 = htpass.randomPassword()

    And 'and generate password 3 with another length', ->
      pass3 = htpass.randomPassword 20

    Then 'Check passwords length', ->
      assert.equal pass1.length, pass2.length
      assert.notEqual pass1.length, pass3.length
      assert.notEqual pass2.length, pass3.length

    Then 'Check if content isnt same', ->
      assert.notEqual pass1, pass2

  Scenario 'Generate bunch of passwords for bunch of users', ->

    users = null
    newUsers = null

    Given 'Get users from file', (done) ->
      inputFile.getCsvFile "#{__dirname}/fixtures/exampleOfInput.csv", (err, returnedUsers) ->
        if err then return done err
        users = returnedUsers
        done()

    And 'generate passwords', (done) ->
      htpass.generatePasswords users, (err, returnedUsers) ->
        if err then return done err
        newUsers = returnedUsers
        done()

    Then 'Check users', ->
      assert.deepEqual Object.keys(newUsers[0]), ['email', 'user', 'url', 'password', 'htaccess']
