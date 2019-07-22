# frozen_string_literal: true

require_relative 'extensions/string'
require_relative 'extensions/hash'

# TODO: When multiple files per directory listed below, use mechanism to require_all
require_relative 'converters/json_to_csv_converter'
require_relative 'parsers/json_parser'

require 'pry'

class Conversion
  attr_accessor :input
  attr_reader :from, :to, :output
  class UnkownConversionFormatError < StandardError; end
  class UnkownIOPathError < StandardError; end

  CONVERSIONS = %w[json csv].freeze

  def initialize(attributes)
    @from, @to = attributes[:from], attributes[:to]
    validate_conversions

    @input, @output = attributes[:input], attributes[:output]
    validate_files
  end

  def convert
    "#{from.upcase}To#{to.upcase}Converter".constantize.new(
      objects: parsed_input,
      file_path: output
    ).convert
  end

  private

  def parsed_input
    @parsed_input ||= "#{from.upcase}Parser".constantize.parse(File.open(input).read)
  end

  def validate_files
    raise UnkownIOPathError unless [input, output].all? do |path|
      File.exist? path
    end
  end

  def validate_conversions
    raise UnkownConversionFormatError if [to, from].any? do |conversion|
      CONVERSIONS.include?(conversion)
    end
  end
end
