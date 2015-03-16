require 'mocha-cakes'
faker = require 'faker'
gpg = require '../src/gpg'

Feature 'GPG encrypt/descrypt message', ->
  message = 'Hello World'
  encryptedMessage = null
  descryptedMessage = null

  Scenario 'Encrypt and decrypt message', ->

    Given 'Encrypt message', (done) ->
      gpg.encryptMessage message, "#{__dirname}/../assets/public_key", (err, msg) ->
        if err then return done err
        encryptedMessage = msg
        done()

    And 'decrypt message', (done) ->
      gpg.decryptMessage encryptedMessage, "#{__dirname}/../assets/private_key", '123456', (err, msg) ->
        if err then return done err
        descryptedMessage = msg
        done()

    Then 'Check messages', ->
      message.should.eql descryptedMessage
