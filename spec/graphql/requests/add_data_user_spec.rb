# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'AddDataToUser', type: :request do
  describe 'mutation addDataToUser' do
    let(:user) { create(:user) }
    let(:user_id) { user.id }
    let(:first_name) { 'John' }
    let(:last_name) { 'Doe' }
    let(:phone) { '1234567890' }
    let(:address) { '456 Elm St' }
    let(:state) { 'CA' }
    let(:zip) { '12345' }

    let(:query) do
      <<~GQL
        mutation {
          addDataToUser(input: {
            userId: #{user_id},
            firstName: "#{first_name}",
            lastName: "#{last_name}",
            phone: "#{phone}",
            address: "#{address}",
            state: "#{state}",
            zip: "#{zip}"
          }) {
            user {
              id
              firstName
              lastName
              phone
              address
              state
              zip
            }
            errors
          }
        }
      GQL
    end

    it 'adds data to an existing user' do
      post '/graphql', params: { query: query }

      json_response = JSON.parse(response.body)
      data = json_response['data']['addDataToUser']

      expect(data['errors']).to be_nil
      expect(data['user']).not_to be_nil
      expect(data['user']['id']).to eq(user_id.to_s)
      expect(data['user']['firstName']).to eq(first_name)
      expect(data['user']['lastName']).to eq(last_name)
      expect(data['user']['phone']).to eq(phone)
      expect(data['user']['address']).to eq(address)
      expect(data['user']['state']).to eq(state)
      expect(data['user']['zip']).to eq(zip)
    end

    it 'returns an error if user is not found' do
      post '/graphql', params: { query: query.gsub("userId: #{user_id}", 'userId: 999') }

      json_response = JSON.parse(response.body)
      data = json_response['data']['addDataToUser']

      expect(data['user']).to be_nil
      expect(data['errors']).to include('User not found')
    end
  end
end