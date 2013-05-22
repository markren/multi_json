require 'yajl' unless defined?(::Yajl)
require 'multi_json/adapter'

module MultiJson
  module Adapters
    # Use the Yajl-Ruby library to dump/load.
    class Yajl < Adapter
      ParseError = if defined?(::Yajl::ParseError)
        ::Yajl::ParseError
      else
        SyntaxError
      end

      def load(string, options={})
        ::Yajl::Parser.new(:symbolize_keys => options[:symbolize_keys]).parse(string)
      end

      def dump(object, options={})
        ::Yajl::Encoder.encode(object, options)
      end
    end
  end
end
