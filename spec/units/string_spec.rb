# frozen_string_literal: true

require_relative '../../lib/extensions/string'

RSpec.describe String do
  describe 'String#constantize' do
    it 'should return the constant with the same identifier as the content as the string' do
      class CoolObject; end

      expect('CoolObject'.constantize).to eq(CoolObject)
    end

    it 'should return nil if passed an empty string' do
      expect(''.constantize).to be_nil
    end
  end
end
