fs = require 'fs'
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
