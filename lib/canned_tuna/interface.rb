module CannedTuna
  module Interface
    def draw component, **args, &block
      component.new(**args).draw_in(self, &block)
    end
  end
end

Prawn::Document.extensions << CannedTuna::Interface
