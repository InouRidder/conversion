# frozen_string_literal: true

require_relative '../lib/conversion'
require_relative 'support/file_helpers'
require 'csv'
require 'json'
require 'pry'

RSpec.describe Conversion do
  include FileHelpers
  let(:example_json_file) { File.join(__dir__, 'examples/users.json') }
  let(:example_csv_file) { File.join(__dir__, 'examples/users.csv') }
  let(:tmp_csv_file) { File.join(__dir__, 'tmp/users.csv') }

  describe 'Conversion#new' do
    it 'should throw an error when given unknown conversion types' do
      expect { Conversion.new(to: :live_mentor, from: :inou) }.to(
        raise_error(UnkownConversionError)
      )
    end

    it ' should throw an error when passed unexisting files' do
      expect { Conversion.new(from: :json, to: :csv, input: 'random_file0', ouput: 'random_file1') }.to(
        raise_error(UnkownIOPathError)
      )
    end

    it 'should return an instance of Conversion when passed correct attributes' do
      actual = Conversion.new(
        input: example_json_file,
        output: tmp_csv_file,
        from: :json,
        to: :csv
      )
      expect(actual).to be_a Conversion
    end
  end

  describe 'Conversion#convert' do
    before(:each) do
      clean_tmp_files([tmp_csv_file])
    end

    it 'should convert json objects to csv rows where the keys are headers' do
      Conversion.new(
        input: example_json_file,
        output: tmp_csv_file,
        from: :json,
        to: :csv
      ).convert

      result = FileUtils.compare_file(
        File.open(example_csv_file),
        File.open(tmp_csv_file)
      )

      expect(result).to be(true)
    end
  end
end
