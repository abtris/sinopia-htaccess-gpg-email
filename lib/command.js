/*
 * decaffeinate suggestions:
 * DS102: Remove unnecessary code created because of implicit returns
 * Full docs: https://github.com/decaffeinate/decaffeinate/blob/master/docs/suggestions.md
 */
const async     = require('async');
const inputFile = require('./input_file');
const htpass = require('./generate');

// Generate and print to output
exports.generate = options =>
  async.waterfall([
    next => inputFile.getCsvFile(options.input, function(err, returnedUsers) {
      if (err) { return next(err); }
      return next(null, returnedUsers);
    }) ,
    (users, next) => inputFile.getKeys(users, function(err, usersWithKeys) {
      if (err) { return next(err); }
      return next(null, usersWithKeys);
    }) ,
    (users, next) => htpass.generatePasswords(users, function(err, usersWithPasswords) {
      if (err) { return next(err); }
      return htpass.saveHtpasswd(users, options.output, err => next(null, usersWithPasswords));
    })
  ], function(err, results) {
    if (err) { console.error("Error", err); }
    return console.log(results);
  })
;
