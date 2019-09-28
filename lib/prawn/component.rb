require "prawn"
require "prawn/component/version"
require "prawn/component/interface"

module Prawn
  class Component
    def self.template &block
      if block_given?
        @template = block
      else
        @template || proc {}
      end
    end

    def render_in pdf, &block
      pdf.instance_exec(self, (block || proc {}), &self.class.template)
    end
  end
end
