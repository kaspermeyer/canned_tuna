require "test_helper"

class OutletTest < Prawn::Component::TestCase
  setup do
    @document = Prawn::Document.new
  end

  test "rendering additional content with outlet" do
    class ContentComponent < Prawn::Component
      template do
        outlet
      end
    end

    @document.instance_exec do
      draw ContentComponent do
        text "Additional content"
      end
    end

    assert_document_includes @document, "Additional content"
  end

  test "rendering additional content with multiple outlets" do
    class OutletComponent < Prawn::Component
      template do
        outlet(:header)
        outlet(:body)
        outlet(:footer)
      end
    end

    @document.instance_exec do
      draw OutletComponent do |content|
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
    end

    assert_document_includes @document, "Header"
    assert_document_includes @document, "Body"
    assert_document_includes @document, "Footer"
  end
end
