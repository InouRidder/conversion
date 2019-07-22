# frozen_string_literal: true
require_relative 'hash'
require_relative 'file_converters/array_to_csv_converter'

module Converters
  class UnkownConversionFormatError < StandardError; end
  CONVERSIONS = %w[json csv].freeze

  def convert_to(attributes)
    raise UnkownConversionFormatError unless included_conversion?(attributes[:conversion])

    send("convert_to_#{attributes[:conversion]}", attributes)
  end

  private

  def convert_to_csv(attributes)
    ArrayToCSVConverter.new(
      array: self,
      file_path: attributes[:file_path]
    ).convert
  end

  def included_conversion?(conversion)
    !CONVERSIONS.include? conversion
  end
end

Array.prepend Converters
