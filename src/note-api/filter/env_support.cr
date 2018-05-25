before_all do |env|
  env.response.content_type = "application/json"
  env.set Env::REQUEST_TIME_MS, Time.new.epoch_ms
end
