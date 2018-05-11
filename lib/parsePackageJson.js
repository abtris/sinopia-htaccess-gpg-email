/*
 * decaffeinate suggestions:
 * DS102: Remove unnecessary code created because of implicit returns
 * Full docs: https://github.com/decaffeinate/decaffeinate/blob/master/docs/suggestions.md
 */
const fs = require('fs');

const parsePackageJson = function(path) {
  const packagejson = JSON.parse(fs.readFileSync(path, "utf8"));
  return packagejson.name + " v" + packagejson.version;
};

module.exports = parsePackageJson;
