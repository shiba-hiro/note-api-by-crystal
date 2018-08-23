module Config
  PORT       = ENV["PORT"] ||= "3000"
  MYSQL_HOST = ENV["MYSQL_HOST"] ||= "localhost"
  MYSQL_PORT = ENV["MYSQL_PORT"] ||= "3306"
  MYSQL_USER = ENV["MYSQL_USER"] ||= "note_db_user"
  MYSQL_PASS = ENV["MYSQL_PASS"] ||= "note_db_pass"
  LOGGING_IO = STDOUT
end

LOGGER = Logger.new Config::LOGGING_IO

Kemal.config.port = Config::PORT.to_i
Kemal.config.logger = Kemal::LogHandler.new Config::LOGGING_IO

Crecto::DbLogger.set_handler(Config::LOGGING_IO)

module Repo
  extend Crecto::Repo

  config do |conf|
    conf.adapter = Crecto::Adapters::Mysql
    conf.database = "note_db"
    conf.hostname = Config::MYSQL_HOST
    conf.username = Config::MYSQL_USER
    conf.password = Config::MYSQL_PASS
    conf.port = Config::MYSQL_PORT.to_i
  end
end

module Crecto::Adapters::Mysql
  private def self.instance_fields_and_values(query_hash : Hash)
    {fields: query_hash.keys, values: query_hash.values.map { |v| v.is_a?(Time) ? v.to_s("%Y-%m-%dT%T.%L") : v.as(DbValue) }}
  end
end
