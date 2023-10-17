# frozen_string_literal: true

module Mutations
  class AddDataToUser < BaseMutation
    argument :user_id, ID, required: true
    argument :first_name, String, required: true
    argument :last_name, String, required: true
    argument :phone, String, required: true
    argument :address, String, required: true
    argument :state, String, required: true
    argument :zip, String, required: true

    field :user, Types::UserType, null: true
    field :errors, [String], null: true

    def resolve(user_id:, first_name:, last_name:, phone:, address:, state:, zip:)
      user = User.find_by(id: user_id)
      
      if user
        user.update!(
          first_name: first_name,
          last_name: last_name,
          phone: phone,
          address: address,
          state: state,
          zip: zip
        )

        { user: user, errors: nil }
      else
        { user: nil, errors: ["User not found"] }
      end
    rescue ActiveRecord::RecordInvalid => e
      { user: nil, errors: e.record.errors.full_messages }
    end
  end
end