# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :admin_user do
    email { Faker::Internet.email }
    password { SecureRandom.hex(16) }
    password_confirmation { password }
  end

  factory :confirmed_admin_user, :parent => :admin_user do
    after(:create) { |user| user.confirm! }
  end
end
