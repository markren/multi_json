require 'multi_json/adapters/json_common'

module MultiJson
  module Adapters
    # Use the JSON gem to dump/load.
    class JsonGem < JsonCommon
      dependencies do
        gem 'json', '~> 1.7.7'
        require 'json/ext'

        ParseError = ::JSON::ParserError
      end

      activate do
        ::JSON.parser     = ::JSON::Ext::Parser
        ::JSON.generator  = ::JSON::Ext::Generator
      end
    end
  end
end