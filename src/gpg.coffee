openpgp = require 'openpgp'
fs = require 'fs'
# https://github.com/openpgpjs/openpgpjs
# Get private/public key from file
exports.getKey = (path) ->
  key = fs.readFileSync path
  return key.toString()

# Encrypt message
exports.encryptMessage = (message, pathToPublicKey, cb) ->
  publicKey = exports.getKey pathToPublicKey
  openpgp.encryptMessage(openpgp.key.readArmored(publicKey).keys, message).then((pgpMessage) ->
    cb null, pgpMessage
  ).catch (error) ->
    console.error "Error in encrypt message", error
    cb error

# Decrypt message
exports.decryptMessage = (pgpMessage, pathToPrivateKey, password, cb) ->
  privateKey = openpgp.key.readArmored(exports.getKey(pathToPrivateKey)).keys[0]
  privateKey.decrypt(password)
  message = openpgp.message.readArmored(pgpMessage)
  openpgp.decryptMessage(privateKey, message).then((plaintext) ->
    cb null, plaintext
  ).catch (error) ->
    console.error "Error in decrypt message", error
    cb error
