before_all do |env|
  next unless Kemal.config.env == "production"

  some_header = env.request.headers["some_header"]?
  if some_header.to_s.empty?
    reject env, status_code: 400, response: {message: "some_header is needed."}.to_json
  end
end
