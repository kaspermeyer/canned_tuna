require "prawn"
require_relative "component/version"
require_relative "component/interface"
require_relative "component/content_proxy"

module Prawn
  class Component
    include Prawn::View

    def self.template &block
      if block_given?
        @template = block
      else
        @template || proc {}
      end
    end

    def draw_in pdf, &block
      register_outlets(&block)

      with_temporary_document(pdf) do
        instance_exec(&self.class.template)
      end
    end

    private

    def content
      @content ||= ContentProxy.new
    end

    def outlet name = :default
      content.outlet_for(name).call
    end

    def with_temporary_document pdf
      @document = pdf
      yield
      @document = nil
    end

    def register_outlets &block
      content_block = block || proc {}

      # Multiple content outlets
      if content_block.arity > 0
        instance_exec(content, &content_block)
      # Default content outlet (short-hand syntax)
      else
        content.outlet(:default, &content_block)
      end
    end
  end
end
