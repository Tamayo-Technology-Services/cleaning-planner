# frozen_string_literal: true

class Company < ApplicationRecord
  validates :company_name, :phone, :email, :address, :city, :state, :zip, presence: true

  belongs_to :user
end
