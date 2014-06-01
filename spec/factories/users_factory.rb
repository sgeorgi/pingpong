require 'faker'

FactoryGirl.define do
  factory :user do
    email { Faker::Internet.email }
    password { SecureRandom.hex(16) }
    password_confirmation { password }

    trait :confirmed do
      after(:create) { |user| user.confirm! }
    end

    trait :with_profile do
      after(:create) { |user| }
    end
  end
end
