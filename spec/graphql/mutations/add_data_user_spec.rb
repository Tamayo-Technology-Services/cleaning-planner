# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Mutations::AddDataToUser do
  describe '#resolve' do
    let(:args) { args = {
        first_name: 'John',
        last_name: 'Doe',
        phone: '123456789',
        address: '1228 La Renaissance',
        state: 'IN',
        zip: '30345'
      }
    }
    it 'should add succesfully the new data' do
      user = create(:user)

      result = Mutations::AddDataToUser.new(object: nil, field: nil, context: {}).resolve(
        user_id: user.id,
        first_name: args[:first_name],
        last_name: args[:last_name],
        phone: args[:phone],
        address: args[:address],
        state: args[:state],
        zip: args[:zip])
      
      user.reload
      expect(result[:user]).to eq(user)
      expect(user.first_name).to eq('John')
      expect(user.last_name).to eq('Doe')
      expect(user.phone).to eq('123456789')
      expect(user.address).to eq('1228 La Renaissance')
      expect(user.state).to eq('IN')
      expect(user.zip).to eq('30345')
    end

    it 'should return the error if the user does not exist' do
      result = Mutations::AddDataToUser.new(object: nil, field: nil, context: {}).resolve(
        user_id: 0,
        first_name: args[:first_name],
        last_name: args[:last_name],
        phone: args[:phone],
        address: args[:address],
        state: args[:state],
        zip: args[:zip])
      expect(result[:user]).to be_nil
      expect(result[:errors]).not_to be_empty
    end
  end
end