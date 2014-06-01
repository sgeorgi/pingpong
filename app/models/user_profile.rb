#
# The User Profile
#
class UserProfile < ActiveRecord::Base
  belongs_to :user
  has_one :profile_address, :class_name => 'Profile::Address'

  validates :name, presence: true

  accepts_nested_attributes_for :profile_address

  def self.create_for_user(_user)
    user_profile = create user: _user, name: _user.email
    Profile::Address.create user_profile: user_profile
    user_profile
  end
end