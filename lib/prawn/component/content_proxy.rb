module Prawn
  class Component
    class ContentProxy
      def initialize &block
        @block = block || proc {}
        @outlets = {}

        instance_exec(self, &@block)
      end

      def outlet_for name
        @outlets[name] || proc {}
      end

      def outlet name = :default, &block
        @outlets[name] = block
      end
    end
  end
end
