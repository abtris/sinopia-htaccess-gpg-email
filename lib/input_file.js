const fs      = require('fs');
const request = require('request');
const async   = require('async');

const COLUMN_SEPARATOR = ';' || process.env.COLUMN_SEPARATOR;

// Get CSV file with COLUMN_SEPARATOR
exports.getCsvFile = function(path, cb) {
  const file = fs.readFileSync(path);
  const lines = file.toString().split("\n");
  const users = [];
  for (let line  of Array.from(lines)) {
    const columns = line.split(`${COLUMN_SEPARATOR}`);
    if (columns[0]) {
      const data = {
        email: columns[0],
        user: columns[0].split("@")[0],
        url: columns[1]
      };
      users.push(data);
    }
  }
  return cb(null, users);
};

exports.downloadKey = (url, cb) =>
  async.waterfall([
    next =>
      request.get(url, function(err, response, body) {
        if (!err && (response.statusCode === 200)) {
          return next(null, body);
        } else {
          return next(err);
        }
      })

  ], function(err, result) {
    if (err) {
      console.error(`Error in download key from '${url}':`, err);
      return cb(err);
    }
    if (result) { return cb(null, result); }
  })
;

exports.getKeys = function(users, cb) {
  const newUsers = [];
  if (Array.isArray(users)) {
    return async.each(users, (function(user, next) {
      if (user.url) {
        return exports.downloadKey(user.url, function(err, publicKey) {
          if (err) { return next(err); }
          user.publicKey = publicKey;
          newUsers.push(user);
          return next();
        });
      } else {
        return next(new Error(`missing public key url ${JSON.stringify(user)}`));
      }
    }), function(err) {
      if (err) { return cb(err); }
      return cb(null, newUsers);
    });
  }
};

exports.getUsersFromFile = (path, cb) =>
  exports.getCsvFile(path, function(err, users) {
    if (err) { return cb(err); }
    return exports.getKeys(users, function(err, usersWithKeys) {
      if (err) { return cb(err); }
      return cb(null, usersWithKeys);
    });
  })
;
