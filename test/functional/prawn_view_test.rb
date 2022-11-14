require "test_helper"

class PrawnViewTest < CannedTuna::TestCase
  test "documents build using Prawn::View" do
    view_document = ViewDocument.new
    view_document.build_document

    assert_document_includes view_document.document, "Modular document"
  end

  class ViewDocument
    include Prawn::View

    def build_document
      draw View, width: 100, height: 100 do
        text "Modular document"
      end
    end
  end

  class View < CannedTuna::Component
    template do
      bounding_box([0, 0], width: width, height: height) do
        outlet
      end
    end

    attr_reader :width, :height

    def initialize(width: 100, height: 100)
      @width, @height = width, height
    end
  end
end
