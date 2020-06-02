require "test_helper"

class ComponentTest < Prawn::Component::TestCase
  setup do
    @document = Prawn::Document.new
  end

  test "defining and accessing the template" do
    class TemplateComponent < Prawn::Component
      template do
        "Inside the template"
      end
    end

    assert_equal "Inside the template", TemplateComponent.template.call
  end

  test "rendering in a prawn document instance" do
    class BasicComponent < Prawn::Component
      template do
        text "Basic"
      end
    end

    BasicComponent.new.draw_in(@document)

    assert_document_includes @document, "Basic"
  end

  test "component methods in template" do
    class ArgumentComponent < Prawn::Component
      template do
        text heading
      end

      attr_reader :heading

      def initialize(heading:)
        @heading = heading
      end
    end

    ArgumentComponent.new(heading: "Argument").draw_in(@document)

    assert_document_includes @document, "Argument"
  end
end
