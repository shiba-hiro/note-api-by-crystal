require "uuid"

require "kemal"
require "mysql"
require "crecto"

require "./note-api/*"

Kemal.config.port = Config::PORT.to_i
Kemal.run
