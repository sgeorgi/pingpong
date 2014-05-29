#
# The User Profile
#
class UserProfile < ActiveRecord::Base
  belongs_to :user
  validates :name, presence: true

  def self.create_for_user(_user)
    create user: _user, name: _user.email
  end
end