exception Exceptions::InvalidRequestFormat do |env, ex|
  response_body = {
    error_code: 1001,
    message:    ex.message,
  }.to_json
  halt env, status_code: 422, response: response_body
end

exception Exceptions::InvalidRequestHeader do |env, ex|
  response_body = {
    error_code: 1002,
    message:    ex.message,
  }.to_json
  halt env, status_code: 400, response: response_body
end
