require 'mocha-cakes'
faker = require 'faker'
assert = require 'assert'
gpg = require '../src/gpg'
htpass = require '../src/generate'
inputFile = require '../src/input_file'

Feature 'GPG encrypt/descrypt message', ->
  message = 'Hello World'
  encryptedMessage = null
  descryptedMessage = null

  Scenario 'Encrypt and decrypt message', ->

    Given 'Encrypt message', (done) ->
      gpg.encryptMessageFromFile message, "#{__dirname}/../assets/public_key", (err, msg) ->
        if err then return done err
        encryptedMessage = msg
        done()

    And 'decrypt message', (done) ->
      gpg.decryptMessageFromFile encryptedMessage, "#{__dirname}/../assets/private_key", '123456', (err, msg) ->
        if err then return done err
        descryptedMessage = msg
        done()

    Then 'Check messages', ->
      message.should.eql descryptedMessage

  Scenario 'Generate bunch of emails', ->

    users = null
    newUsers = null
    userWithEmails = null

    Given 'Get users from file', (done) ->
      inputFile.getUsersFromFile "#{__dirname}/fixtures/exampleOfInput.csv", (err, returnedUsers) ->
        if err then return done err
        users = returnedUsers
        done()

    And 'generate passwords', (done) ->
      htpass.generatePasswords users, (err, returnedUsers) ->
        if err then return done err
        newUsers = returnedUsers
        done()

    And 'set public keys', (done) ->
      for user in newUsers
        user.publicKey = gpg.getKey "#{__dirname}/../assets/public_key"
      done()

    And 'generate emails', (done) ->
      gpg.generateEncryptedEmail newUsers, (err, returnedUsers) ->
        if err then return done err
        userWithEmails = returnedUsers
        done()

    Then 'check keys in users', ->
      assert.deepEqual Object.keys(userWithEmails[0]), ["user","publicKey","password","htaccess","pgpMessage"]
