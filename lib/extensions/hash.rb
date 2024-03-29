# frozen_string_literal: true

module ConversionHashExtension
  class HashExtraction
    attr_accessor :keys, :values

    def initialize
      @keys = []
      @values = []
    end

    def extract_keys(hash, prefix = '')
      # Thinking about creating a 'traversable' duck type for any map like object that can recursively traversed
      hash.each do |key, value|
        if value.is_a? Hash
          extract_keys(value, "#{prefix}#{key}.")
        else
          keys << "#{prefix}#{key}"
        end
      end
      keys
    end

    def extract_values(hash)
      hash.each do |_key, value|
        if value.is_a? Hash
          extract_values(value)
        else
          values << normalize(value)
        end
      end
      values
    end

    def normalize(value)
      value.is_a?(Array) ? value.join(',') : value.to_s
    end
  end

  def extract_values
    HashExtraction.new.extract_values(self)
  end

  def extract_keys
    HashExtraction.new.extract_keys(self)
  end
end

Hash.prepend ConversionHashExtension
