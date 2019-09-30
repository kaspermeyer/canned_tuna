module Prawn
  class Component
    module Interface
      def draw component, *args, &block
        component.new(*args).draw_in(self, &block)
      end
    end
  end
end

Prawn::Document.extensions << Prawn::Component::Interface
