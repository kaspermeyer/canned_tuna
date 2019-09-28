require "minitest/autorun"

module Prawn
  class Component
    class TestCase < MiniTest::Test
      class << self
        def setup(&block)
          define_method(:setup, &block)
        end

        def teardown(&block)
          define_method(:teardown, &block)
        end

        def test(name, &block)
          define_method("test_#{name}".gsub(/\W/, "_"), &block)
        end
      end

      def assert_document_includes document, string
        output = PDF::Inspector::Text.analyze(document.render)

        assert_includes output.strings, string
      end
    end
  end
end
