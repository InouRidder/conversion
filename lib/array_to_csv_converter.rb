# frozen_string_literal: true

class ArrayToCSVConverter
  attr_reader :array
  attr_accessor :converted

  def initialize(attributes)
    @converted = []
    @array = attributes[:array]
  end

  def convert
    set_headers
    array.each do |hash|

    end
  end

  private

  def set_headers
    array.first.fetch_keys
  end

  def write_to_file(options)
    file_path = generate_file_path(options[:file_path])
    File.open(filepath, 'wb') do |file|
      file.write(converted)
    end
  end

  def generate_file_path(file_path)
    file_path||= Tempfile.new.path
  end
end
