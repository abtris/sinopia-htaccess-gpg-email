openpgp = require 'openpgp'
fs = require 'fs'
async = require 'async'
# https://github.com/openpgpjs/openpgpjs
# Get private/public key from file
exports.getKey = (path) ->
  key = fs.readFileSync path
  return key.toString()

# Encrypt message public key in file
exports.encryptMessageFromFile = (message, pathToPublicKey, cb) ->
  publicKey = exports.getKey pathToPublicKey
  exports.encryptMessageFromString message, publicKey, cb

# Encrypt message public key as string
exports.encryptMessageFromString = (message, publicKey, cb) ->
  openpgp.encryptMessage(openpgp.key.readArmored(publicKey).keys, message).then((pgpMessage) ->
    cb null, pgpMessage
  ).catch (error) ->
    console.error "Error in encrypt message", error
    cb error

# Decrypt message, private key from file
exports.decryptMessageFromFile = (pgpMessage, pathToPrivateKey, password, cb) ->
  privateKey = openpgp.key.readArmored(exports.getKey(pathToPrivateKey)).keys[0]
  privateKey.decrypt(password)
  message = openpgp.message.readArmored(pgpMessage)
  openpgp.decryptMessage(privateKey, message).then((plaintext) ->
    cb null, plaintext
  ).catch (error) ->
    console.error "Error in decrypt message", error
    cb error

# Generate encrypted password messages
exports.generateEncryptedEmail = (users, cb) ->
  if Array.isArray users
    newUsers = []
    async.each users, ((user, next) ->
      if user.publicKey
        exports.encryptMessageFromString "Your password is: #{user.password}", user.publicKey, (err, pgpMessage) ->
         if err then return next err
         user.pgpMessage = pgpMessage
         newUsers.push user
         next()
      else
        next new Error "missing public key #{JSON.stringify user}"
    ), (err) ->
      if err then return cb err
      cb null, newUsers
