# frozen_string_literal: true

require "minitest/autorun"

module Prawn
  module Component
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
    end
  end
end
