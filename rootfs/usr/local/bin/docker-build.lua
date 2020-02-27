#!/usr/bin/lua
local core = require("docker-core")

local function wp_cli_setup(bin)
  core.run("wget -q -O %s/wp https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar", bin)
  core.run("chmod +x %s/wp", bin)
end

local function main()
  local bin = "/usr/local/bin"
  local www = "/var/www"
  local project = "/tmp/wordpress"
  local version = "5.3.2"
  wp_cli_setup(bin)
  core.run("apk add --no-cache lua-rex-pcre")
  core.run("%s/composer create-project --no-install --no-interaction johnpbloch/wordpress:%s %s", bin, version, project)
  core.run("%s/composer --working-dir=%s install", bin, project)
  core.run("tar -czf %s/wordpress.tgz -C %s .", www, project)
  core.run("%s/composer clear-cache", bin)
  core.run("rm -rf %s", project)
end

main()
