const assert = require('assert');
const http   = require('http');
const fs     = require('fs');

const inputFile = require('../lib/input_file');

// Feature('Input file tests', function() {

//   Scenario('Get input file from fixtures', function() {

//     let users = null;

//     Given('Read file', done =>
//       inputFile.getCsvFile(`${__dirname}/fixtures/exampleOfInput.csv`, function(err, returnedUsers) {
//         if (err) { return done(err); }
//         users = returnedUsers;
//         return done();
//       })
//     );

//     return Then('Check users', () => assert.ok(users.length === 4));
//   });

//   Scenario('Get input file with custom separator', function() {

//     let users = null;

//     Given('Read file', function(done) {
//       process.env.COLUMN_SEPARATOR = "|";
//       return inputFile.getCsvFile(`${__dirname}/fixtures/changeSeparator.csv`, function(err, returnedUsers) {
//         if (err) { return done(err); }
//         users = returnedUsers;
//         return done();
//       });
//     });

//     return Then('Check users', () => assert.ok(users.length === 3));
//   });

//   return Scenario('Download file from url', function() {

//     let public_key_file = null;

//     Given('Create http server with public key', function(done) {
//       const public_key = fs.readFileSync(`${__dirname}/../assets/public_key`);
//       http.createServer( function(req, res) {
//         res.writeHead(200, {'Content-Type': 'text/plain'});
//         return res.end(public_key);
//       }).listen(9615);

//       return inputFile.downloadKey("http://localhost:9615/", function(err, body) {
//         public_key_file = body;
//         return done(err);
//       });
//     });

//     return Then('Test donwloaded file', () => public_key_file.should.match(/^-----BEGIN PGP PUBLIC KEY BLOCK-----/));
//   });
// });
