module Prawn
  class Component
    module Interface
      def component component, *args, &block
        component.new(*args).render_in(self, &block)
      end
    end
  end
end

Prawn::Document.extensions << Prawn::Component::Interface
