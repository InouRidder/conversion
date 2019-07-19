class Hash
  class HashExtraction
    attr_accessor :keys
    attr_reader :hash
    def initialize(hash)
      @hash = hash
      @keys = []
    end

    def extract_keys(hash = nil, prefix = '')
      hash ||= self.hash

      hash.each do |key, value|
        if value.is_a? Hash
          fetch_keys(value, "#{key}.")
        else
          keys << "#{prefix}#{key}"
        end
      end
      keys
    end
  end

  def extract_keys
    HashExtraction.new(self).extract_keys
  end
end
