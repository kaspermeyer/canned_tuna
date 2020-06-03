require "test_helper"

class OutletTest < CannedTuna::TestCase
  test "rendering content with outlet" do
    document = Prawn::Document.new {
      draw ContentComponent do
        text "Additional content"
      end
    }

    assert_document_includes document, "Additional content"
  end

  test "rendering content with multiple outlets" do
    document = Prawn::Document.new {
      draw NamedOutletComponent do |content|
        content.outlet(:header) do
          text "Header"
        end

        content.outlet(:body) do
          text "Body"
        end

        content.outlet(:footer) do
          text "Footer"
        end
      end
    }

    ["Header", "Body", "Footer"].each do |outlet_text|
      assert_document_includes document, outlet_text
    end
  end

  test "outlet with default content" do
    document = Prawn::Document.new {
      draw DefaultContentComponent
    }

    assert_document_includes document, "Default content"
  end

  test "multiple outlets with default content" do
    document = Prawn::Document.new {
      draw DefaultContentsComponent do |content|
        content.outlet(:body) do
          text "Body"
        end
      end
    }

    ["Header", "Body", "Footer"].each do |outlet_text|
      assert_document_includes document, outlet_text
    end
  end

  class ContentComponent < CannedTuna::Component
    template do
      outlet
    end
  end

  class NamedOutletComponent < CannedTuna::Component
    template do
      outlet(:header)
      outlet(:body)
      outlet(:footer)
    end
  end

  class DefaultContentComponent < CannedTuna::Component
    template do
      outlet do
        text "Default content"
      end
    end
  end

  class DefaultContentsComponent < CannedTuna::Component
    template do
      outlet(:header) { text "Header" }
      outlet(:body)
      outlet(:footer) { text "Footer" }
    end
  end
end
