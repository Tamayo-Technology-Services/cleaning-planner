# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'SignInUser', type: :request do
  describe 'mutation signInUser' do
    let(:user) { create(:user, email: 'test@example.com', password: 'password123') }

    let(:query) do
      <<~GQL
        mutation {
          signinUser(input: {
            credentials: {
              email: "#{user.email}",
              password: "password123"
            }
          }) {
            token
            user {
              id
              email
            }
          }
        }
      GQL
    end

    it 'signs in an existing user' do
      post '/graphql', params: { query: query }

      json_response = JSON.parse(response.body)
      data = json_response['data']['signinUser']

      expect(data['token']).not_to be_nil
      expect(data['user']).not_to be_nil
      expect(data['user']['id']).to eq(user.id.to_s)
      expect(data['user']['email']).to eq(user.email)
    end

    it 'returns null for token and user if invalid credentials are provided' do
      post '/graphql', params: { query: query.gsub('password123', 'wrongpassword') }

      json_response = JSON.parse(response.body)
      data = json_response['data']['signinUser']
      expect(data).to be_nil
    end
  end
end