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
