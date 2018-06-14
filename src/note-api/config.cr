module Config
  PORT       = ENV["PORT"] ||= "3000"
  MYSQL_HOST = ENV["MYSQL_HOST"] ||= "localhost"
  MYSQL_PORT = ENV["MYSQL_PORT"] ||= "3306"
  MYSQL_USER = "note_db_user"
  MYSQL_PASS = "note_db_pass"
end

LOGGER = Logger.new(STDOUT)
