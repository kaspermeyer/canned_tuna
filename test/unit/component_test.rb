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

  test "accessing component in template" do
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

  test "rendering additional content" do
    class ContentComponent < Prawn::Component
      template do |content|
        content.call(self)
      end
    end

    ContentComponent.new.draw_in(@document) do |pdf|
      pdf.text "Additional content"
    end

    assert_document_includes @document, "Additional content"
  end
end
