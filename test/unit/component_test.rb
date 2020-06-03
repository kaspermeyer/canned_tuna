require "test_helper"

class ComponentTest < CannedTuna::TestCase
  setup do
    @document = Prawn::Document.new
  end

  test "defining and accessing the template" do
    assert_equal "Inside the template", TemplateComponent.template.call
  end

  test "rendering in a prawn document instance" do
    BasicComponent.new.draw_in(@document)

    assert_document_includes @document, "Basic"
  end

  test "component methods in template" do
    ArgumentComponent.new(heading: "Argument").draw_in(@document)

    assert_document_includes @document, "Argument"
  end

  class TemplateComponent < CannedTuna::Component
    template do
      "Inside the template"
    end
  end

  class BasicComponent < CannedTuna::Component
    template do
      text "Basic"
    end
  end

  class ArgumentComponent < CannedTuna::Component
    template do
      text heading
    end

    attr_reader :heading

    def initialize(heading:)
      @heading = heading
    end
  end
end
