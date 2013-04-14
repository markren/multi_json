require 'singleton'
require 'multi_json/options'

module MultiJson
  class Adapter
    extend Options
    include Singleton
    class << self

      def defaults(action, value)
        define_metaclass_method("default_#{action}_options"){ value }
      end

      def dependencies(&block)
        define_metaclass_method 'resolve_dependencies!' do
          return if @_dependencies_resolved
          block.call
          @_dependencies_resolved = true
        end
      end

      def activate(&block)
        define_metaclass_method 'run_load_hooks!', &block
      end

      def load(string, options={})
        instance.load(string, collect_load_options(string, options))
      end

      def dump(object, options={})
        instance.dump(object, collect_dump_options(object, options))
      end

    protected

      def collect_load_options(string, options)
        collect_options :load_options, options, [ string, options ]
      end

      def collect_dump_options(object, options)
        collect_options :dump_options, options, [ object, options ]
      end

      def collect_options(method, overrides, args)
        global, local = *[MultiJson, self].map{ |r| r.send(method, *args) }
        local.merge(global).merge(overrides)
      end

    private

      def metaclass
        class << self; self; end
      end

      def define_metaclass_method(*args, &block)
        metaclass.instance_eval{ define_method(*args, &block) }
      end

    end
  end
end