require 'rails_helper'

describe User do

  describe 'ASSOCIATIONS' do
    it 'has one #user_profile' do
      expect(build :user).to have_one(:user_profile)
    end
  end

  describe 'CALLBACKS' do
    describe 'after_initialize #create_user_profile' do
      it 'calls UserProfile.create_for_user(self) upon creation' do
        user = build :user
        expect(UserProfile).to receive(:create_for_user).with(user)
        user.save
      end
    end
  end
end
