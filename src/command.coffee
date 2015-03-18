async     = require 'async'
inputFile = require 'input_file'
htpass = require 'generate'

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
    (users, next) -> mailgun.sendEmails users, (err, results) ->
      if err then return next err
      next null, results
  ], (err, results) ->
  if err then console.error "Error", err
  console.log results
