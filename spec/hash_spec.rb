# frozen_string_literal: true

require 'json'
require 'pry'
require_relative '../lib/hash'

RSpec.describe Hash do
  describe 'Hash#extract_keys' do
    let(:data) { JSON.parse(File.open(File.join(__dir__, 'examples/users.json')).read) }

    it 'should return the headers of a simple hash' do
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
end
