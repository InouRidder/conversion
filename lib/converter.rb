# frozen_string_literal: true

class Converter
  attr_reader :collection
  attr_accessor :converted
  def initialize(collection)
    @converted = []
    @collection = collection
  end

  def convert(options)

  end

  private

  def write_to_file(file_path)
    file_path = generate_file_path(options[:file_path])
    File.open(filepath, 'wb') do |file|
      file.write(converted)
    end
  end

  def generate_file_path(file_path)
    file_path||= Tempfile.new.path
  end
end
