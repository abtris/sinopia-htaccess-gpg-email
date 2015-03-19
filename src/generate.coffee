fs = require 'fs'
crypto = require 'crypto'
crypt3 = require 'crypt3'
async = require 'async'

# Generate htpasswd password
exports.generate_htpasswd = (user, passwd) ->
  if user isnt encodeURIComponent(user)
    err = Error('username shouldn\'t contain non-uri-safe characters')
    err.status = 409
    throw err
  passwd = '{SHA}' + crypto.createHash('sha1').update(passwd, 'binary').digest('base64')
  newline = user + ':' + passwd
  newline

# Verify password
exports.verify_password = (user, passwd, hash) ->
  if hash.indexOf('{PLAIN}') == 0
    passwd == hash.substr(7)
  else if hash.indexOf('{SHA}') == 0
    crypto.createHash('sha1').update(passwd, 'binary').digest('base64') == hash.substr(5)
  else
    false

exports.make_passwd = make_passwd = (n, a) ->
  index = (Math.random() * (a.length - 1)).toFixed(0)
  if n > 0 then a[index] + make_passwd(n - 1, a) else ''

exports.randomPassword = (length = 14) ->
  exports.make_passwd length, 'qwertyuiopasdfghjklzxcvbnmQWERTYUIOPASDFGHJKLZXCVBNM1234567890!@#$%^&*()_+'

exports.generatePasswords = (users, cb) ->
  if Array.isArray users
    newUsers = []
    for user in users
      pass = exports.randomPassword 20
      user.password = pass
      user.htaccess = exports.generate_htpasswd user.user, pass
      newUsers.push user
    cb null, newUsers

exports.saveHtpasswd = (users, outputFile, cb) ->
  output = []
  async.eachSeries users, ((user, next) ->
    output.push user.htaccess
    next()
  ), (err) ->
    if err then return cb err
    fs.writeFileSync outputFile, output.join("\n")
    cb()
