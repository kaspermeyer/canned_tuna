require "prawn"
require_relative "component/version"
require_relative "component/interface"

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
      with_temporary_document(pdf) do
        instance_exec((block || -> {}), &self.class.template)
      end
    end

    private

    def with_temporary_document pdf
      @document = pdf
      yield
      @document = nil
    end
  end
end
