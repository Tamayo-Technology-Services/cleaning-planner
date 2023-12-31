require 'rails_helper'

RSpec.describe Mutations::CreateUser do
  describe '#resolve' do
    it 'creates a new user' do
      args = {
        name: 'Test User',
        auth_provider: {
          credentials: {
            email: 'email@example.com',
            password: '[omitted]'
          }
        }
      }

      result = Mutations::CreateUser.new(object: nil, field: nil, context: {}).resolve(name: args[:name], auth_provider: args[:auth_provider])
      user = result

      expect(user).to be_persisted
      expect(user.name).to eq('Test User')
      expect(user.email).to eq('email@example.com')
    end
    context 'when email address already exists' do
      it 'does not create a new user' do
        existing_user = create(:user, email: 'existing_email@example.com') # Create a user with existing email address

        args = {
          name: 'Test User',
          auth_provider: {
            credentials: {
              email: 'existing_email@example.com',
              password: '[omitted]'
            }
          }
        }

        result = Mutations::CreateUser.new(object: nil, field: nil, context: {}).resolve(name: args[:name], auth_provider: args[:auth_provider])
        expect(result).to be_a(GraphQL::ExecutionError)
        expect(result.message).to eq('Email address is already in use')
      end
    end
  end
end
