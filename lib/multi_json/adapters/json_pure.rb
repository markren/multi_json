require 'multi_json/adapters/json_common'

module MultiJson
  module Adapters
    class JsonPure < JsonCommon
      dependencies do
        gem 'json_pure', '~> 1.7.7'
        require 'json/pure'
        ParseError = ::JSON::ParserError
      end

      activate do
        ::JSON.parser     = ::JSON::Pure::Parser
        ::JSON.generator  = ::JSON::Pure::Generator
      end
    end
  end
end
