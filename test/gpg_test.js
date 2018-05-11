const faker = require('faker');
const assert = require('assert');
const gpg = require('../lib/gpg');
const htpass = require('../lib/generate');
const inputFile = require('../lib/input_file');

// Feature('GPG encrypt/descrypt message', function() {
//   const message = 'Hello World';
//   let encryptedMessage = null;
//   let descryptedMessage = null;

//   Scenario('Encrypt and decrypt message', function() {

//     Given('Encrypt message', done =>
//       gpg.encryptMessageFromFile(message, `${__dirname}/../assets/public_key`, function(err, msg) {
//         if (err) { return done(err); }
//         encryptedMessage = msg;
//         return done();
//       })
//     );

//     And('decrypt message', done =>
//       gpg.decryptMessageFromFile(encryptedMessage, `${__dirname}/../assets/private_key`, '123456', function(err, msg) {
//         if (err) { return done(err); }
//         descryptedMessage = msg;
//         return done();
//       })
//     );

//     return Then('Check messages', () => message.should.eql(descryptedMessage));
//   });

//   return Scenario('Generate bunch of emails', function() {

//     let users = null;
//     let newUsers = null;
//     let userWithEmails = null;

//     Given('Get users from file', done =>
//       inputFile.getCsvFile(`${__dirname}/fixtures/exampleOfInput.csv`, function(err, returnedUsers) {
//         if (err) { return done(err); }
//         users = returnedUsers;
//         return done();
//       })
//     );

//     And('generate passwords', done =>
//       htpass.generatePasswords(users, function(err, returnedUsers) {
//         if (err) { return done(err); }
//         newUsers = returnedUsers;
//         return done();
//       })
//     );

//     And('set public keys', function(done) {
//       for (let user of Array.from(newUsers)) {
//         user.publicKey = gpg.getKey(`${__dirname}/../assets/public_key`);
//       }
//       return done();
//     });

//     And('generate emails', done =>
//       gpg.generateEncryptedEmail(newUsers, function(err, returnedUsers) {
//         if (err) { return done(err); }
//         userWithEmails = returnedUsers;
//         return done();
//       })
//     );

//     return Then('check keys in users', () => assert.deepEqual(Object.keys(userWithEmails[0]), ["email","user","url","password","htaccess","publicKey","pgpMessage"]));
// });
// });
