# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'CreateCompany', type: :request do
  describe 'mutation createCompany' do
    let(:user) { create(:user) } # Create a user to associate with the company
    let(:query) do
      <<~GQL
        mutation {
          createCompany(
            input: {
              companyName: "Example Company",
              phone: "123456789",
              email: "company@example.com",
              address: "123 Main St",
              city: "Example City",
              state: "CA",
              zip: "12345",
              userId: #{user.id}
            }
          ) {
            company {
              id
              companyName
              phone
              email
              address
              city
              state
              zip
            }
            errors
          }
        }
      GQL
    end

    it 'creates a new company' do
      post '/graphql', params: { query: query }

      json_response = JSON.parse(response.body)
      data = json_response['data']['createCompany']

      expect(data['errors']).to be_nil
      expect(data['company']).not_to be_nil
      expect(data['company']['companyName']).to eq('Example Company')
      expect(data['company']['phone']).to eq('123456789')
      expect(data['company']['email']).to eq('company@example.com')
      expect(data['company']['address']).to eq('123 Main St')
      expect(data['company']['city']).to eq('Example City')
      expect(data['company']['state']).to eq('CA')
      expect(data['company']['zip']).to eq('12345')
    end
  end
end
