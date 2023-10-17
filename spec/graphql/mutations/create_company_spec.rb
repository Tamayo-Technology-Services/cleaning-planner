# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Mutations::CreateCompany do
  describe '#resolve' do
    let(:user) { create(:user) } # Create a user to associate with the company

    context 'with valid input' do
      it 'creates a new company' do
        args = {
          company_name: 'Example Company',
          phone: '123456789',
          email: 'company@example.com',
          address: '123 Main St',
          city: 'Example City',
          state: 'CA',
          zip: '12345',
          user_id: user.id
        }

        result = Mutations::CreateCompany.new(object: nil, field: nil, context: {}).resolve(
          company_name: args[:company_name],
          phone: args[:phone],
          email: args[:email],
          address: args[:address],
          city: args[:city],
          state: args[:state],
          zip: args[:zip],
          user_id: args[:user_id]
        )

        company = result[:company]
        expect(company).to be_persisted
        expect(company.company_name).to eq('Example Company')
        expect(company.phone).to eq('123456789')
        expect(company.email).to eq('company@example.com')
        expect(company.address).to eq('123 Main St')
        expect(company.city).to eq('Example City')
        expect(company.state).to eq('CA')
        expect(company.zip).to eq('12345')
        expect(company.user).to eq(user)
      end
    end

    context 'with invalid input' do
      it 'returns errors' do
        args = {
          company_name: '',
          phone: '123456789',
          email: 'company@example.com',
          address: '123 Main St',
          city: 'Example City',
          state: 'CA',
          zip: '12345',
          user_id: user.id
        }

        result = Mutations::CreateCompany.new(object: nil, field: nil, context: {}).resolve(
          company_name: args[:company_name],
          phone: args[:phone],
          email: args[:email],
          address: args[:address],
          city: args[:city],
          state: args[:state],
          zip: args[:zip],
          user_id: args[:user_id]
        )

        expect(result[:company]).to be_nil
        expect(result[:errors]).to include("Company name can't be blank")
      end
    end
  end
end