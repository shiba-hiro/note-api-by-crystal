module Env
  REQUEST_TIME_MS = "request_time_ms"
end

macro reject(env, status_code, response)
  {{env}}.response.status_code = {{status_code}}
  {{env}}.response.print {{response}}
  raise Kemal::Exceptions::CustomException.new({{env}})
end

# control filter order
require "./filter/header_filter"
require "./filter/env_support"
