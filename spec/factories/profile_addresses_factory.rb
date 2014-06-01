require 'forgery'

FactoryGirl.define do
  factory :profile_address, :class => 'Profile::Address' do
    street_1 { Forgery::Address.street_address }
    street_2 ''
    city { Forgery::Address.city }
    postal_code  { Forgery::Address.zip }
  end
end
