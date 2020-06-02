require "test_helper"

class NestedComponentsTest < Prawn::Component::TestCase
  test "nested components with additional content" do
    document = Prawn::Document.new {
      draw Header do
        text "Header"
      end

      draw Body do
        draw Section, heading: "Primary text" do
          text "Secondary text"
        end
      end

      draw Footer do
        text "Footer"
      end
    }

    ["Header", "Primary text", "Secondary text", "Footer"].each do |text|
      assert_document_includes document, text
    end
  end

  class Header < Prawn::Component
    HEIGHT = 50

    template do
      bounding_box bounds.top_left, width: bounds.width, height: Header::HEIGHT do
        outlet
      end
    end
  end

  class Body < Prawn::Component
    template do
      width = bounds.width
      height = bounds.height - Footer::HEIGHT - Header::HEIGHT

      bounding_box [bounds.left, bounds.top - Footer::HEIGHT], width: width, height: height do
        pad_top(5) do
          outlet
        end
      end
    end
  end

  class Section < Prawn::Component
    template do
      text heading
      outlet
    end

    attr_reader :heading

    def initialize heading:
      @heading = heading
    end
  end

  class Footer < Prawn::Component
    HEIGHT = 20

    template do
      bounding_box [bounds.left, bounds.bottom], width: bounds.width, height: Footer::HEIGHT do
        outlet
      end
    end
  end
end
