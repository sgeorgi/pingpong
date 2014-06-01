require 'spec_helper'

describe UserProfile do
  it 'creates from a Factory' do
    expect { create :user_profile }.not_to raise_error
  end

  describe 'VALIDATIONS' do
    describe '#name' do
      it 'fails validation unless present' do
        expect(build :user_profile, name: nil).to have(1).error_on(:name)
      end
    end
  end

  describe 'ASSOCIATIONS' do
    describe '#user' do
      let(:user_profile) { UserProfile.new }

      it 'belongs to User' do
        expect(user_profile).to belong_to(:user)
      end

      it 'has one profile_address' do
        expect(user_profile).to have_one(:profile_address)
      end
    end
  end

  describe '.create_for_user' do
    it 'creates and saves a new instance for a given User' do
      expect_any_instance_of(UserProfile).to receive(:save).exactly(2).times
      UserProfile.create_for_user(build :user)
    end

    it 'sets the #name temporarily to User#email' do
      user = build :user, email: 'my@email.com'
      expect(UserProfile.create_for_user(user).name).to eq('my@email.com')
    end

    it 'creates a Profile::Address' do
      user = build :user
      expect(UserProfile.create_for_user(user).profile_address).not_to be_nil
    end
  end
end