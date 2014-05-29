#
# User model class that represents an account and is used and depended on by Devise
#
class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  has_one :user_profile

  after_create :create_user_profile

  private

  def create_user_profile
    UserProfile.create_for_user(self)
  end
end
