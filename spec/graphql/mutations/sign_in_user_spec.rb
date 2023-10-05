require 'rails_helper'

RSpec.describe Mutations::SignInUser do
  describe '#resolve' do
    it 'returns a token and user on successful sign-in' do
      user = create_user
      args = {
        credentials: {
          email: user.email,
          password: 'password'
        }
      }

      result = Mutations::SignInUser.new(object: nil, field: nil, context: { session: {} }).resolve(credentials: args[:credentials])
      expect(result[:token]).to be_present
      expect(result[:user]).to eq(user)
    end

    it 'returns nil when no credentials are provided' do
      args = { credentials: { email: nil, password: nil } }

      result = Mutations::SignInUser.new(object: nil, field: nil, context: { session: {} }).resolve(credentials: args[:credentials])

      expect(result).to be_nil
    end

    it 'returns nil for wrong email' do
      create_user
      args = { credentials: { email: 'wrong', password: 'password' } }

      result = Mutations::SignInUser.new(object: nil, field: nil, context: { session: {} }).resolve(credentials: args[:credentials])

      expect(result).to be_nil
    end

    it 'returns nil for wrong password' do
      user = create_user
      args = { credentials: { email: user.email, password: 'wrong' } }

      result = Mutations::SignInUser.new(object: nil, field: nil, context: { session: {} }).resolve(credentials: args[:credentials])

      expect(result).to be_nil
    end
  end

  def create_user
    User.create!(
      name: 'Test User',
      email: 'email@example.com',
      password: 'password'
    )
  end
end
