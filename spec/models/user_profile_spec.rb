require 'spec_helper'

describe UserProfile do
  it 'creates from a Factory' do
    expect { create :user_profile }.not_to raise_error
  end

  describe 'ATTRIBUTES' do
    let(:user_profile) { UserProfile.new }

    describe '#name' do
      it 'responds to name' do
        expect(user_profile).to respond_to(:name)
        expect(user_profile).to respond_to(:name=)
      end
    end
  end

  describe 'VALIDATIONS' do
    describe '#name' do
      it 'fails validation unless present' do
        expect(build :user_profile, name: nil).to have(1).error_on(:name)
      end
    end
  end

  describe 'ASSOCIATIONS' do
    it 'belongs to User' do
      expect(build :user_profile).to belong_to(:user)
    end
  end
end