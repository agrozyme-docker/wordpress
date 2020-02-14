#!/usr/bin/lua
local core = require("docker-core")

local function create_project(html)
  local json = html .. "/composer.json"

  if (core.test("! -f %s", json)) then
    core.run("tar -zxf %s/../wordpress.tgz -C %s", html, html)
  end

  core.chown(html)
end

local function main()
  local html = "/var/www/html"
  core.update_user()
  create_project(html)
  core.clear_path("/run/php-fpm7")
  core.run("php-fpm7 -F")
end

main()
