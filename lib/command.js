const async     = require('async');

const inputFile = require('./input_file');
const htpass = require('./generate');

// Generate and print to output
exports.generate = options =>
  async.waterfall([
    (next) => inputFile.getCsvFile(options.input, (err, returnedUsers) => {
      if (err) { return next(err); }
      next(null, returnedUsers);
    }) ,
    (users, next) => htpass.generatePasswords(users, (err, usersWithPasswords) => {
      if (err) { return next(err); }
      next(null, usersWithPasswords);
    })
  ], (err, results) => {
    if (err) { console.error("Error", err); }
    console.log(results);
  });
