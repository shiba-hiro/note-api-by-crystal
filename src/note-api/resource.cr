get "/health-check" do |env|
  app_state = {message: "Application is running.", success: true}

  begin
    Repo.raw_scalar("SELECT CURRENT_TIMESTAMP();")
    db_state = {message: "Database is available.", success: true}
  rescue e
    LOGGER.fatal("Database is not available because of #{e.class}")
    LOGGER.fatal(e.inspect_with_backtrace)
    db_state = {message: "Database is available.", success: false}
  end

  halt env, status_code: 200, response: {app: app_state, db_connection: db_state}.to_json
end

require "./resource/*"
