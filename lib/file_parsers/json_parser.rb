# frozen_string_literal: true

require 'json'

class JSONParser
  class << self
    def parse(input)
      JSON.parse(input)
    end
  end
end
