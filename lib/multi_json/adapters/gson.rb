require 'multi_json/adapter'

module MultiJson
  module Adapters
    # Use the gson.rb library to dump/load.
    class Gson < Adapter
      dependencies do
        gem 'gson', '>= 0.6'
        require 'gson'
        ParseError = ::Gson::DecodeError
      end

      def load(string, options={})
        ::Gson::Decoder.new(options).decode(string)
      end

      def dump(object, options={})
        ::Gson::Encoder.new(options).encode(object)
      end
    end
  end
end
