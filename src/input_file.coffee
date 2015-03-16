fs = require 'fs'

exports.getCsvFile = (path, cb) ->
  file = fs.readFileSync path
  lines = file.toString().split("\n")
  users = []
  for line  in lines
    columns = line.split(";")
    if columns[0]
      data =
        user: columns[0]
        url: columns[1]
      users.push data
  cb null, users
