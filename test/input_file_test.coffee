require 'mocha-cakes'
assert = require 'assert'
http   = require 'http'
fs     = require 'fs'

inputFile = require '../src/input_file'

Feature 'Input file tests', ->

  Scenario 'Get input file from fixtures', ->

    users = null

    Given 'Read file', (done) ->
      inputFile.getCsvFile "#{__dirname}/fixtures/exampleOfInput.csv", (err, returnedUsers) ->
        if err then return done err
        users = returnedUsers
        done()

    Then 'Check users', ->
      assert.ok users.length is 4

  Scenario 'Get input file with custom separator', ->

    users = null

    Given 'Read file', (done) ->
      process.env.COLUMN_SEPARATOR = "|"
      inputFile.getCsvFile "#{__dirname}/fixtures/changeSeparator.csv", (err, returnedUsers) ->
        if err then return done err
        users = returnedUsers
        done()

    Then 'Check users', ->
      assert.ok users.length is 3

  Scenario 'Download file from url', ->

    public_key_file = null

    Given 'Create http server with public key', (done) ->
      public_key = fs.readFileSync "#{__dirname}/../assets/public_key"
      http.createServer( (req, res) ->
        res.writeHead 200, {'Content-Type': 'text/plain'}
        res.end public_key
      ).listen(9615)

      inputFile.downloadKey "http://localhost:9615/", (err, body) ->
        public_key_file = body
        done err

    Then 'Test donwloaded file', ->
      public_key_file.should.match /^-----BEGIN PGP PUBLIC KEY BLOCK-----/
