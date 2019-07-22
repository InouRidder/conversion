# frozen_string_literal: true

require_relative 'hash'
# TODO: When multiple files per directory listed below, use mechanism to require_all
require_relative 'file_converters/array_to_csv_converter'
require_relative 'file_parsers/json_parser'

class Conversion
  attr_accessor :input
  attr_reader :from, :to, :output
  class UnkownConversionFormatError < StandardError; end
  CONVERSIONS = %w[json csv].freeze

  def initialize(attributes)
    @input, @output = attributes[:input], attributes[:output]
    check_for_files

    @from, @to = attributes[:from], attributes[:to]
    check_for_conversions

    parse_input
  end

  def convert
    "#{from}To#{to}Converter".constantize.new(
      objects: input,
      file_path: attributes[:file_path]
    ).convert
  end

  private

  def parse_input
    self.input = "#{from.upcase}Parser".constantize.parse(input)
  end

  def check_for_files
    raise 'Enter valid file path' unless [input, output].all? do |path|
      File.exist? path
    end
  end

  def check_for_conversions
    raise UnkownConversionFormatError unless [to, from].all? do |conversion|
      included_conversion?(conversion)
    end
  end

  def included_conversion?(conversion)
    !CONVERSIONS.include? conversion
  end
end
