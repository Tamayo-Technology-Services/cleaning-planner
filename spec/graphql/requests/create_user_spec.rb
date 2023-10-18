# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'CreateUser', type: :request do
  describe 'createUser' do
    let(:auth_provider) { { credentials: { email: 'test@example.com', password: 'password123' } } }
    let(:name) { 'Test User' }
    let(:query) do
      <<~GQL
        mutation {
          createUser(input: {
            name: "#{name}",
            authProvider: {
              credentials: {
                email: "#{auth_provider[:credentials][:email]}",
                password: "#{auth_provider[:credentials][:password]}"
              }
            }
          }) {
              id
              name
              email
          }
        }
      GQL
    end

    it 'creates a new user' do
      post '/graphql', params: { query: query }
      json_response = JSON.parse(response.body)
      data = json_response['data']['createUser']
      expect(data).not_to be_nil
      expect(data['name']).to eq(name)
      expect(data['email']).to eq(auth_provider[:credentials][:email])
    end

    it 'returns an error if email address is already in use' do
      create(:user, email: auth_provider[:credentials][:email])
      post '/graphql', params: { query: query }

      json_response = JSON.parse(response.body)
      data = json_response['data']['createUser']

      expect(data).to be_nil
      expect(json_response['errors'].first['message']).to include('Email address is already in use')
    end
  end
end
