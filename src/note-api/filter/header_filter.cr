before_all do |env|
  next unless Kemal.config.env == "production"
  raise Exceptions::InvalidRequestHeader.new header_name: "some_header" if env.request.headers["some_header"]?.to_s.empty?
end
