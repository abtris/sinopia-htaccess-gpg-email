const faker = require('faker');
const assert = require('assert');
const mktemp  = require('mktemp');
const fs = require('fs');
const htpass = require('../lib/generate');
const inputFile = require('../lib/input_file');

describe('Test generate htpassd password', () => {

  describe('Generate password for dummy user', () => {

    let user = null;
    const password = '123456';
    let hashedLine = null;

    user = faker.name.firstName().toLowerCase();
    hashedLine = htpass.generate_htpasswd(user, password);

    it('Check password', () => assert.ok(htpass.verify_password(user, password, hashedLine.split(":")[1])));
  });

//   Scenario('Generate dummy password', function() {

//     let pass1 = null;
//     let pass2 = null;
//     let pass3 = null;

//     Given('Generate random password 1', () => pass1 = htpass.randomPassword());

//     And('and generate password 2', () => pass2 = htpass.randomPassword());

//     And('and generate password 3 with another length', () => pass3 = htpass.randomPassword(20));

//     Then('Check passwords length', function() {
//       assert.equal(pass1.length, pass2.length);
//       assert.notEqual(pass1.length, pass3.length);
//       return assert.notEqual(pass2.length, pass3.length);
//     });

//     return Then('Check if content isnt same', () => assert.notEqual(pass1, pass2));
//   });

//   return Scenario('Generate bunch of passwords for bunch of users', function() {

//     let users = null;
//     let newUsers = null;
//     const tempFile = mktemp.createFileSync('XXXXX.tmp');

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

//     And('save to file', done =>
//       htpass.saveHtpasswd(newUsers, tempFile, function(err) {
//         if (err) { return done(err); }
//         return done();
//       })
//     );

//     Then('Check keys in users', () => assert.deepEqual(Object.keys(newUsers[0]), ['email', 'user', 'url', 'password', 'htaccess']));

//     return Then('Check output file', function() {
//       assert.equal(4, fs.readFileSync(tempFile).toString().split("\n").length);
//       return fs.unlinkSync(tempFile);
//     });
//   });
});
