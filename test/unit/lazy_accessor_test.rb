require "test_helper"

class LazyAccessorTest < Prawn::Component::TestCase
  setup do
    @document = Prawn::Document.new
  end

  test "lazily accessing document state" do
    component = LazyComponent.new
    component.draw_in(@document)

    assert_document_includes @document, "Current page is 1"
  end

  test "returns nil outside of a document context" do
    component = LazyComponent.new

    assert_nil component.page_number
  end

  class LazyComponent < Prawn::Component
    template do
      text "Current page is #{page_number}"
    end

    def page_number
      lazy { page_number }
    end
  end
end
