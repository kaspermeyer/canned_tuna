module CannedTuna
  class ContentProxy
    def initialize
      @outlets = {}
    end

    def outlet_for name, &default_content
      @outlets[name] || default_content || proc {}
    end

    def outlet name = :default, &block
      @outlets[name] = block
    end
  end
end
