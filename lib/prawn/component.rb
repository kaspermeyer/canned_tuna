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

    def outlet name = :default, &default_content
      content.outlet_for(name, &default_content).call
    end

    def with_temporary_document pdf
      @document = pdf
      yield
      @document = nil
    end

    def register_outlets &block
      return unless block_given?

      # Multiple content outlets
      if block.arity > 0
        instance_exec(content, &block)
      # Default content outlet (short-hand syntax)
      else
        content.outlet(:default, &block)
      end
    end
  end
end
