require 'multi_json/adapter'

module MultiJson
  module Adapters
    # Use the Oj library to dump/load.
    class Oj < Adapter
      defaults :load, :mode => :strict, :symbolize_keys => false
      defaults :dump, :mode => :compat, :time_format => :ruby

      dependencies do
        gem 'oj', '~> 2.0'
        require 'oj'
        ParseError = ::Oj::ParseError
      end

      def load(string, options={})
        options[:symbol_keys] = options.delete(:symbolize_keys)
        ::Oj.load(string, options)
      end

      def dump(object, options={})
        options.merge!(:indent => 2) if options[:pretty]
        ::Oj.dump(object, options)
      end
    end
  end
end