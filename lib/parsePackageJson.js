const fs = require('fs');

const parsePackageJson = function(path) {
  const packagejson = JSON.parse(fs.readFileSync(path, "utf8"));
  return packagejson.name + " v" + packagejson.version;
};

module.exports = parsePackageJson;
