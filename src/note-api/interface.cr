module ZonedDateTimeConverter
  def self.to_json(value : Time, json : JSON::Builder)
    json.string(value.to_s("%Y-%m-%dT%T.%L%:z"))
  end
end

require "./interface/*"
