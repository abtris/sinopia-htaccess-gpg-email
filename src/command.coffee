async     = require 'async'
inputFile = require './input_file'
htpass = require './generate'
gpg = require './gpg'
mailgun = require './mailgun'

sendEmails = (users, sender, subject, cb) ->
  if Array.isArray users
    async.each users, ((user, next) ->
      if user.email
        options =
          recipient: user.email
          sender: sender
          subject: subject
          message: user.pgpMessage
        mailgun.sendEmail options, (err) ->
          if err then return next err
          next()
      else
        next new Error "missing email #{JSON.stringify user}"
    ), (err) ->
      if err then return cb err
      cb()
  else
    cb new Error "Empty input array"

# Command line
exports.send = (options) ->
  async.waterfall [
    (next) -> inputFile.getCsvFile options.input, (err, returnedUsers) ->
      if err then return next err
      next null, returnedUsers
    (users, next) -> inputFile.getKeys users, (err, usersWithKeys) ->
      if err then return next err
      next null, usersWithKeys
    (users, next) -> htpass.generatePasswords users, (err, usersWithPasswords) ->
      if err then return next err
      next null, usersWithPasswords
    (users, next) -> gpg.generateEncryptedEmail users, (err, usersWithEmails) ->
      if err then return next err
      next null, usersWithEmails
    (users, next) -> sendEmails users, options.sender, options.subject, (err) ->
      if err then return next err
      next()
  ], (err) ->
    if err then console.error "Error", err
