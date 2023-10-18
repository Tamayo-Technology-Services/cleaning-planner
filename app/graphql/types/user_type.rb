module Types
  class UserType < Types::BaseObject
    field :id, ID, null: false
    field :name, String, null: false
    field :email, String, null: false

    field :first_name, String, null: true
    field :last_name, String, null: true
    field :phone, String, null: true
    field :address, String, null: true
    field :state, String, null: true
    field :zip, String, null: true
  end
end
