fs      = require 'fs'
mktemp  = require 'mktemp'
request = require 'request'
async   = require 'async'

COLUMN_SEPARATOR = ';' or process.env.COLUMN_SEPARATOR

# Get CSV file with COLUMN_SEPARATOR
exports.getCsvFile = (path, cb) ->
  file = fs.readFileSync path
  lines = file.toString().split "\n"
  users = []
  for line  in lines
    columns = line.split "#{COLUMN_SEPARATOR}"
    if columns[0]
      data =
        email: columns[0]
        user: columns[0].split("@")[0]
        url: columns[1]
      users.push data
  cb null, users

exports.downloadKey = (url, cb) ->
  async.waterfall [
    (next) ->
      request.get url, (err, response, body) ->
        if !err && response.statusCode is 200
          next null, body
        else
          next err
  ], (err, result) ->
    if err
      console.error "Error in download key from '#{url}':", err
      return cb err
    cb null, result if result

exports.getKeys = (users, cb) ->
  newUsers = []
  if Array.isArray users
    for user in users
      if user
        user.publicKey = exports.downloadKey(user.url) or null
        newUsers.push user
    cb null, newUsers

exports.getUsersFromFile = (path, cb) ->
  exports.getCsvFile path, (err, users) ->
    if err then return cb err
    exports.getKeys users, (err, usersWithKeys) ->
      if err then return cb err
      cb null, usersWithKeys
