/*
 * decaffeinate suggestions:
 * DS102: Remove unnecessary code created because of implicit returns
 * Full docs: https://github.com/decaffeinate/decaffeinate/blob/master/docs/suggestions.md
 */
// https://github.com/1lobby/mailgun-js
if (!process.env.MAILGUN_API_KEY || !process.env.MAILGUN_DOMAIN) {
  throw new Error("Missing MAILGUN_API_KEY and MAILGUN_DOMAIN");
}

const api_key = process.env.MAILGUN_API_KEY;
const domain = process.env.MAILGUN_DOMAIN;
const mailgun = require('mailgun-js')({
  apiKey: api_key,
  domain});

exports.sendEmail = function({recipient, sender, subject, message}, cb) {

  const data = {
    from: sender,
    to: recipient,
    subject,
    text: message
  };

  return mailgun.messages().send(data, function(err, body) {
    if (err) { return cb(err); }
    console.log("Send email", body);
    return cb();
  });
};
