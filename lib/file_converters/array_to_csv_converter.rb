# frozen_string_literal: true

class ArrayToCSVConverter
  attr_reader :array, :file_path
  attr_accessor :converted

  def initialize(attributes)
    raise 'Enter valid file path' unless File.exist?(attributes[:file_path])

    @converted = []
    @array = attributes[:array]
    @file_path = attributes[:file_path]
  end

  def convert
    array.each do |hash|
      converted << hash.extract_values
    end
    write_to_file
  end

  private

  def headers
    array.first.extract_keys
  end

  def write_to_file
    # I would have added: { force_quotes: true, quote_char: '"' } as options, but I wanted to exactly match the provided example for the sake of the test
    csv_options = { col_sep: ',' }

    CSV.open(file_path, 'wb', csv_options) do |csv|
      csv << headers
      converted.each { |convert| csv << convert }
    end
  end
end
