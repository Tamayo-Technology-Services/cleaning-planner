# frozen_string_literal: true

# app/graphql/types/company_type.rb
module Types
  class CompanyType < Types::BaseObject
    description "A company object."

    field :id, ID, null: false
    field :company_name, String, null: true
    field :phone, String, null: true
    field :email, String, null: true
    field :address, String, null: true
    field :city, String, null: true
    field :state, String, null: true
    field :zip, String, null: true
    field :user, Types::UserType, null: true
  end
end
