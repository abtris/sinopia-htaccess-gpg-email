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

  describe('Generate dummy password', () => {

    let pass1 = htpass.randomPassword();
    let pass2 = htpass.randomPassword();
    let pass3 = htpass.randomPassword(20);

    it('Check passwords length', () => {
      assert.equal(pass1.length, pass2.length);
      assert.notEqual(pass1.length, pass3.length);
      assert.notEqual(pass2.length, pass3.length);
    });

    it('Check if content isnt same', () => assert.notEqual(pass1, pass2));
  });

  describe('Generate bunch of passwords for bunch of users', () => {

    let users = null;
    let newUsers = null;
    const tempFile = mktemp.createFileSync('XXXXX.tmp');

    describe('Get users from file', (done) => {
      inputFile.getCsvFile(`${__dirname}/fixtures/exampleOfInput.csv`, (err, returnedUsers) => {
        if (err) { return done(err); }
        users = returnedUsers;
        htpass.generatePasswords(users, function (err, returnedUsers) {
          if (err) { return done(err); }
          newUsers = returnedUsers;
          htpass.saveHtpasswd(newUsers, tempFile, function (err) {
            if (err) { return done(err); }
            it('Check keys in users', () => assert.deepEqual(Object.keys(newUsers[0]), ['email', 'user', 'url', 'password', 'htaccess']));

            it('Check output file', () => {
              assert.equal(4, fs.readFileSync(tempFile).toString().split("\n").length);
              fs.unlinkSync(tempFile);
            });
          });
        });
      });
    });
  });
});
