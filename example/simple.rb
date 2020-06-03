require_relative "../lib/canned_tuna"

class Box < CannedTuna::Component
  template do
    bounding_box([0, cursor - 100], width: width, height: height) do
      outlet
      draw_border
    end
  end

  attr_reader :width, :height

  def initialize(width: 100, height: 100)
    @width, @height = width, height
  end

  def draw_border
    transparent(0.5) { stroke_bounds }
  end
end

Prawn::Document.generate("simple.pdf") do
  draw Box, width: 200, height: 100 do
    text "Inside the box"
  end
end
