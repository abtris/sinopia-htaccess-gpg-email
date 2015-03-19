# https://github.com/1lobby/mailgun-js
unless (process.env.MAILGUN_API_KEY and process.env.MAILGUN_DOMAIN)
  throw new Error "Missing MAILGUN_API_KEY and MAILGUN_DOMAIN"

api_key = process.env.MAILGUN_API_KEY
domain = process.env.MAILGUN_DOMAIN
mailgun = require('mailgun-js')(
  apiKey: api_key
  domain: domain)

exports.sendEmail = ({recipient, sender, subject, message}, cb) ->

  data =
    from: sender
    to: recipient
    subject: subject
    text: message

  mailgun.messages().send data, (err, body) ->
    if err then return cb err
    console.log "Send email", body
    cb()
