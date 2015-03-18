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
        user: columns[0]
        url: columns[1]
      users.push data
  cb null, users

exports.downloadKey = (url, cb) ->
  async.waterfall [
    (next) ->
      request.get url, (err, response, body) ->
        if !err && response.statusCode is 200
          next null, body
  ], (err, result) ->
    if err then console.error "Error in download key from '#{url}':", err
    cb null, result

exports.getKeys = (users, cb) ->
  newUsers = null
  if Array.isArray users
    for user in users
      data =
        user: user.user
        publicKey: exports.downloadKey user.url
      newUsers.push data
    cb null, newUsers
