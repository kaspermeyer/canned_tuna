require "test_helper"

class InterfaceTest < Prawn::Component::TestCase
  test "rendering a component" do
    document = Prawn::Document.new {
      component BasicComponent
    }

    assert_document_includes document, "Basic"
  end

  test "rendering a component with arguments" do
    document = Prawn::Document.new {
      component ArgumentComponent, text: "Argument"
    }

    assert_document_includes document, "Argument"
  end

  test "rendering a component with additional content" do
    document = Prawn::Document.new {
      component ContentComponent do
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
    template do |component|
      text component.text
    end

    attr_reader :text

    def initialize(text:)
      @text = text
    end
  end

  class ContentComponent < Prawn::Component
    template do |_, content|
      content.call
    end
  end
end
