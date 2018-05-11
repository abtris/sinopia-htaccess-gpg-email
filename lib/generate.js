/*
 * decaffeinate suggestions:
 * DS101: Remove unnecessary use of Array.from
 * DS102: Remove unnecessary code created because of implicit returns
 * DS207: Consider shorter variations of null checks
 * Full docs: https://github.com/decaffeinate/decaffeinate/blob/master/docs/suggestions.md
 */
let make_passwd;
const fs = require('fs');
const crypto = require('crypto');
const async = require('async');

// Generate htpasswd password
exports.generate_htpasswd = function(user, passwd) {
  if (user !== encodeURIComponent(user)) {
    const err = Error('username shouldn\'t contain non-uri-safe characters');
    err.status = 409;
    throw err;
  }
  passwd = `{SHA}${crypto.createHash('sha1').update(passwd, 'binary').digest('base64')}`;
  const newline = user + ':' + passwd;
  return newline;
};

// Verify password
exports.verify_password = function(user, passwd, hash) {
  if (hash.indexOf('{PLAIN}') === 0) {
    return passwd === hash.substr(7);
  } else if (hash.indexOf('{SHA}') === 0) {
    return crypto.createHash('sha1').update(passwd, 'binary').digest('base64') === hash.substr(5);
  } else {
    return false;
  }
};

exports.make_passwd = (make_passwd = function(n, a) {
  const index = (Math.random() * (a.length - 1)).toFixed(0);
  if (n > 0) { return a[index] + make_passwd(n - 1, a); } else { return ''; }
});

exports.randomPassword = function(length) {
  if (length == null) { length = 14; }
  return exports.make_passwd(length, 'qwertyuiopasdfghjklzxcvbnmQWERTYUIOPASDFGHJKLZXCVBNM1234567890!@#$%^&*()_+');
};

exports.generatePasswords = function(users, cb) {
  if (Array.isArray(users)) {
    const newUsers = [];
    for (let user of Array.from(users)) {
      const pass = exports.randomPassword(20);
      user.password = pass;
      user.htaccess = exports.generate_htpasswd(user.user, pass);
      newUsers.push(user);
    }
    return cb(null, newUsers);
  }
};

exports.saveHtpasswd = function(users, outputFile, cb) {
  const output = [];
  return async.eachSeries(users, (function(user, next) {
    output.push(user.htaccess);
    return next();
  }), function(err) {
    if (err) { return cb(err); }
    fs.writeFileSync(outputFile, output.join("\n"));
    return cb();
  });
};
