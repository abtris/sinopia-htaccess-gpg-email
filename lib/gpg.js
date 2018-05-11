/*
 * decaffeinate suggestions:
 * DS102: Remove unnecessary code created because of implicit returns
 * Full docs: https://github.com/decaffeinate/decaffeinate/blob/master/docs/suggestions.md
 */
const openpgp = require('openpgp');
const fs = require('fs');
const async = require('async');
// https://github.com/openpgpjs/openpgpjs
// Get private/public key from file
exports.getKey = function(path) {
  const key = fs.readFileSync(path);
  return key.toString();
};

// Encrypt message public key in file
exports.encryptMessageFromFile = function(message, pathToPublicKey, cb) {
  const publicKey = exports.getKey(pathToPublicKey);
  return exports.encryptMessageFromString(message, publicKey, cb);
};

// Encrypt message public key as string
exports.encryptMessageFromString = (message, publicKey, cb) =>
  openpgp.encryptMessage(openpgp.key.readArmored(publicKey).keys, message).then(pgpMessage => cb(null, pgpMessage)).catch(function(error) {
    console.error("Error in encrypt message", error);
    return cb(error);
  })
;

// Decrypt message, private key from file
exports.decryptMessageFromFile = function(pgpMessage, pathToPrivateKey, password, cb) {
  const privateKey = openpgp.key.readArmored(exports.getKey(pathToPrivateKey)).keys[0];
  privateKey.decrypt(password);
  const message = openpgp.message.readArmored(pgpMessage);
  return openpgp.decryptMessage(privateKey, message).then(plaintext => cb(null, plaintext)).catch(function(error) {
    console.error("Error in decrypt message", error);
    return cb(error);
  });
};

// Generate encrypted password messages
exports.generateEncryptedEmail = function(users, cb) {
  if (Array.isArray(users)) {
    const newUsers = [];
    return async.each(users, (function(user, next) {
      if (user.publicKey) {
        return exports.encryptMessageFromString(`Your password is: ${user.password}`, user.publicKey, function(err, pgpMessage) {
         if (err) { return next(err); }
         user.pgpMessage = pgpMessage;
         newUsers.push(user);
         return next();
        });
      } else {
        return next(new Error(`missing public key ${JSON.stringify(user)}`));
      }
    }), function(err) {
      if (err) { return cb(err); }
      return cb(null, newUsers);
    });
  }
};
