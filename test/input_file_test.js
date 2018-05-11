const assert = require('assert');
const http   = require('http');
const fs     = require('fs');

const inputFile = require('../lib/input_file');

describe('Input file tests', () => {

  describe('Get input file from fixtures', () => {

    let users = null;

    describe('Read file', () => {
      inputFile.getCsvFile(`${__dirname}/fixtures/exampleOfInput.csv`, (err, returnedUsers) => {
        if (err) { return err; }
        users = returnedUsers;
        it('Check users', () => assert.ok(users.length === 4));
      });
    });

  });

  describe('Get input file with custom separator', () => {
    let users = null;
    process.env.COLUMN_SEPARATOR = "|";
    inputFile.getCsvFile(`${__dirname}/fixtures/changeSeparator.csv`, (err, returnedUsers) => {
      if (err) { return err; }
      users = returnedUsers;
      it('Check users', () => assert.ok(users.length === 3));
    });
  });

  describe('Download file from url', () => {

    let public_key_file = null;
    let server = null;

    const public_key = fs.readFileSync(`${__dirname}/../assets/public_key`);
    before( (done) => {
      server = http.createServer((req, res) => {
        res.writeHead(200, { 'Content-Type': 'text/plain' });
        return res.end(public_key);
      }).listen(9615);

      inputFile.downloadKey("http://localhost:9615/", (err, body) => {
        public_key_file = body;
        server.close(() => done(err));
      });
    });
    it('Test downloaded file', () => public_key_file.should.match(/^-----BEGIN PGP PUBLIC KEY BLOCK-----/));
  });
});
