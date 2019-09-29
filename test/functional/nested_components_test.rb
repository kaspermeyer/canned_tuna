require "test_helper"

class NestedComponentsTest < Prawn::Component::TestCase
  test "nested components with additional content" do
    document = Prawn::Document.new {
      component Header do
        text "Header"
      end

      component Body do
        component Section, text: "Primary text" do
          text "Secondary text"
        end
      end

      component Footer do
        text "Footer"
      end
    }

    ["Header", "Primary text", "Secondary text", "Footer"]. each do |text|
      assert_document_includes document, text
    end
  end

  class Header < Prawn::Component
    HEIGHT = 50

    template do |_, content|
      bounding_box bounds.top_left, width: bounds.width, height: Header::HEIGHT do
        content.call
      end
    end
  end

  class Body < Prawn::Component
    template do |_, content|
      width = bounds.width
      height = bounds.height - Footer::HEIGHT - Header::HEIGHT

      bounding_box [bounds.left, bounds.top - Footer::HEIGHT], width: width, height: height do
        pad_top(5) do
          content.call
        end
      end
    end
  end

  class Section < Prawn::Component
    template do |component, content|
      text component.text
      content.call
    end

    attr_reader :text

    def initialize text:
      @text = text
    end
  end

  class Footer < Prawn::Component
    HEIGHT = 20

    template do |_, content|
      bounding_box [bounds.left, bounds.bottom], width: bounds.width, height: Footer::HEIGHT do
        content.call
      end
    end
  end
end
