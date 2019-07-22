# frozen_string_literal: true

class JSONToCSVConverter
  attr_reader :objects, :file_path
  attr_accessor :converted

  def initialize(attributes)
    @converted = []
    @objects = attributes[:objects]
    @file_path = attributes[:file_path]
  end

  def convert
    objects.each do |hash|
      converted << hash.extract_values
    end
    write_to_file
  end

  private

  def headers
    objects.first.extract_keys
  end

  def write_to_file
    # I would have added: { force_quotes: true, quote_char: '"' } as options,
    # but I wanted to exactly match the provided example for the sake of the test

    csv_options = { col_sep: ',' }

    CSV.open(file_path, 'wb', csv_options) do |csv|
      csv << headers
      converted.each { |convert| csv << convert }
    end
  end
end
