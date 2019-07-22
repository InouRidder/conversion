# frozen_string_literal: true

require_relative '../../lib/converters/json_to_csv_converter'
require_relative '../support/file_helpers'
require 'json'
require 'pry'

RSpec.describe JSONToCSVConverter do
  include FileHelpers

  describe 'JSONToCSVConverter#convert' do
    let(:many_objects) do
      JSON.parse(File.open(safe_path('examples/users.json')).read)
    end
    let(:single_object) do
      {
        'name' => 'Lebron James',
        'role' => 'King',
        'meaning of life' => 42
      }
    end
    let(:output) { safe_path('tmp/users.csv') }
    let(:example_csv_file) { safe_path('examples/users.csv') }

    before(:each) do
      clean_tmp_files([output])
    end

    it 'should write an array of hashes to a csv file' do
      JSONToCSVConverter.new(
        objects: many_objects,
        output_file_path: output
      ).convert

      expect(identical_files?(example_csv_file, output)).to be_truthy
    end

    it 'should write a single hash to a csv' do
      JSONToCSVConverter.new(
        objects: single_object,
        output_file_path: output
      ).convert

      actual = File.open(output).read
      expected = 'name,role,meaning_of_life\nLebron James,King,42\n'

      expect(actual).to eq(actual)
    end

    it 'should not break when given an empty object' do
      converter = JSONToCSVConverter.new(
        objects: single_object,
        output_file_path: output
      )

      expect(converter.convert).to_not be(nil)
    end
  end
end
