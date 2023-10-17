# frozen_string_literal: true

# app/graphql/mutations/create_company.rb
module Mutations
  class CreateCompany < BaseMutation
    argument :company_name, String, required: true
    argument :phone, String, required: true
    argument :email, String, required: true
    argument :address, String, required: true
    argument :city, String, required: true
    argument :state, String, required: true
    argument :zip, String, required: true
    argument :user_id, ID, required: true

    field :company, Types::CompanyType, null: true
    field :errors, [String], null: true

    def resolve(company_name:, phone:, email:, address:, city:, state:, zip:, user_id:)
      user = User.find_by(id: user_id)

      if user.nil?
        return { company: nil, errors: ['User not found'] }
      end

      company = user.build_company(
        company_name: company_name,
        phone: phone,
        email: email,
        address: address,
        city: city,
        state: state,
        zip: zip
      )

      if company.save
        { company: company, errors: nil }
      else
        { company: nil, errors: company.errors.full_messages }
      end
    end
  end
end
