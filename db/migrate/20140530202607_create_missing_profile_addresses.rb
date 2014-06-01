class CreateMissingProfileAddresses < ActiveRecord::Migration
  def up
    user_profiles = UserProfile.select { |user_profile| user_profile.profile_address.nil? }
    user_profiles.each { |user_profile| Profile::Address.create user_profile: user_profile }
  end
end
