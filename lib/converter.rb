# frozen_string_literal: true

module Converters
  class Converter
    attr_reader :collection
    def initialize(collection)
      @collection = collection
    end
  end
end
