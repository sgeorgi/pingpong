class CreateMissingUserProfiles < ActiveRecord::Migration
  def up
    users = User.select { |user| user.user_profile.nil? }
    users.each { |user| UserProfile.create_for_user user }
  end
end
