# frozen_string_literal: true

require 'json'
require 'pry'
require_relative '../lib/extensions/hash'

RSpec.describe Hash do
  let(:data) { JSON.parse(File.open(File.join(__dir__, 'examples/users.json')).read) }

  describe 'Hash#extract_keys' do
    it 'should return the keys of a simple hash' do
      simple_hash = {
        'level' => '1',
        'live' => 'mentor'
      }

      expect(simple_hash.extract_keys).to eq(simple_hash.keys)
    end

    it 'should return all keys of a complex hash with nested denoated by dots' do
      actual = data.first.extract_keys
      expected = %w[id email tags profiles.facebook.id profiles.facebook.picture profiles.twitter.id profiles.twitter.picture]
      expect(actual).to eq(expected)
    end
  end

  describe 'Hash#extract_values' do
    it 'should return the values of a simple hash' do
      simple_hash = {
        'level' => '1',
        'live' => 'mentor'
      }

      expect(simple_hash.extract_values).to eq(simple_hash.values)
    end

    it 'should return all values of a nested hash' do
      actual = data.first.extract_values
      expected = %w[0 colleengriffith@quintity.com consectetur,quis 0 //fbcdn.com/a2244bc1-b10c-4d91-9ce8-184337c6b898.jpg 0 //twcdn.com/ad9e8cd3-3133-423e-8bbf-0602e4048c22.jpg]
      expect(actual).to eq(expected)
    end
  end
end
