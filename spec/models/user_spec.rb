require 'spec_helper'

describe User do

  describe 'ASSOCIATIONS' do
    describe '#user_profile' do
      it 'has one #user_profile' do
        expect(build :user).to have_one(:user_profile)
      end
    end
  end

end
