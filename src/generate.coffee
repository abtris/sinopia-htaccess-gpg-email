crypto = require 'crypto'
crypt3 = require 'crypt3'

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
