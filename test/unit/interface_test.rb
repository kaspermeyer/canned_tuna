require "test_helper"

class InterfaceTest < Prawn::Component::TestCase
  test "rendering a component" do
    document = Prawn::Document.new {
      draw BasicComponent
    }

    assert_document_includes document, "Basic"
  end

  test "rendering a component with arguments" do
    document = Prawn::Document.new {
      draw ArgumentComponent, heading: "Argument"
    }

    assert_document_includes document, "Argument"
  end

  test "rendering a component with additional content" do
    document = Prawn::Document.new {
      draw ContentComponent do
        text "Content"
      end
    }

    assert_document_includes document, "Content"
  end

  class BasicComponent < Prawn::Component
    template do
      text "Basic"
    end
  end

  class ArgumentComponent < Prawn::Component
    template do
      text heading
    end

    attr_reader :heading

    def initialize(heading:)
      @heading = heading
    end
  end

  class ContentComponent < Prawn::Component
    template do |content|
      content.call
    end
  end
end
