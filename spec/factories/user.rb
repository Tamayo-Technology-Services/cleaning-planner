# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    sequence :email do |n|
      "user#{n}@example.com" # Generates unique email addresses like user1@example.com, user2@example.com, and so on.
    end
    name { 'Test User' }
    password { 'password' } # Set a default password or adjust it according to your needs
  end
end