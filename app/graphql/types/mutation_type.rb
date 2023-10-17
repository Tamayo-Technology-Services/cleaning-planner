# frozen_string_literal: true

module Types
  class MutationType < Types::BaseObject
    field :create_user, mutation: Mutations::CreateUser
    field :signin_user, mutation: Mutations::SignInUser
    field :add_data_to_user, mutation: Mutations::AddDataToUser
    field :create_company, mutation: Mutations::CreateCompany
  end
end
