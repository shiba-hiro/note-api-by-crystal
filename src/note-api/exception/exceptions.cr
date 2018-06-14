module Exceptions
  class InvalidRequestFormat < Exception
    def initialize(@body_name : String, @cause : Exception? = nil)
      super "Invalid request format of #{body_name} was thrown."
    end
  end

  class InvalidRequestHeader < Exception
    def initialize(@header_name : String, @cause : Exception? = nil)
      super "#{header_name} is needed."
    end
  end
end
