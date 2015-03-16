crypto = require 'crypto'
crypt3 = require 'crypt3'

# Generate htpasswd password
exports.generate_htpasswd = (user, passwd) ->
  if user isnt encodeURIComponent(user)
    err = Error('username shouldn\'t contain non-uri-safe characters')
    err.status = 409
    throw err
  if crypt3
    passwd = crypt3(passwd)
  else
    passwd = '{SHA}' + crypto.createHash('sha1').update(passwd, 'binary').digest('base64')
  newline = user + ':' + passwd
  newline
