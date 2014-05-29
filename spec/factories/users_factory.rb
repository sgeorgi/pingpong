require 'faker'

FactoryGirl.define do
  factory :user do
    email { Faker::Internet.email }
    password { SecureRandom.hex(16) }
    password_confirmation { password }
  end

  factory :confirmed_user, :parent => :user do
    after(:create) { |user| user.confirm! }
  end
end
