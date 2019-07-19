# frozen_string_literal: true

module Converters
  class UnkownConversionFormatError < StandardError; end
  CONVERSIONS = %w[json csv].freeze

  def convert_to(attributes)
    raise UnkownConversionFormatError unless included_conversion? attributes[:conversion]

    send("convert_to_#{attributes[:conversion]}!", attributes[:file_path])
  end

  private

  def convert_to_csv(file_path)
    Converter.new(self).convert(
      to: :csv,
      file_path: file_path
    )
  end

  def included_conversion?(conversion)
    !CONVERSIONS.include? conversion
  end
end

Enumerable.prepend Converters
