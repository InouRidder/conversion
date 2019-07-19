# frozen_string_literal: true

require_relative '../lib/converters'
require 'csv'
require 'tempfile'
require 'json'

RSpec.describe Converters do
  describe 'Converters#convert_to' do
    let(:json_file) { File.join(__dir__, 'examples/users.json') }

    it 'should convert json objects to csv rows where the keys are headers' do
      temp = Tempfile.new('csv').tap do |f|
        f << JSON.generate(File.open(json_file).read)
      end

      result = FileUtils.compare_file(
        File.open(File.join(__dir__, 'examples/users.csv')),
        temp
      )

      expect(result).to be(true)
    end

    # it 'should convert a csv to a collection of json objects' do
    #   CSV.open('examples/users.csv') do |csv|
    #     @temp_file = Tempfile.create { |f| f << csv.convert_to(:json) }
    #   end

    #   result = FileUtils.compare_file(
    #     './examples/users.json',
    #     @temp_file.path
    #   )

    #   expect(result).to be(true)
    # end
  end
end
