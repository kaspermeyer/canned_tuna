require_relative "../lib/prawn/component"

class Box < Prawn::Component
  template do |component, content|
    bounding_box([0, cursor - 100], width: component.width, height: component.height) do
      content.call
      transparent(0.5) { stroke_bounds }
    end
  end

  attr_reader :width, :height

  def initialize(width: 100, height: 100)
    @width, @height = width, height
  end
end

Prawn::Document.generate("simple.pdf") do
  draw Box, width: 200, height: 100 do
    text "Inside the box"
  end
end
