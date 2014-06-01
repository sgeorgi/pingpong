require 'spec_helper'

describe UserProfilesController do
  context 'when logged in' do
    before(:each) do
      @user = create :user, :confirmed
      sign_in @user
    end

    describe 'GET #show /user_profile' do
      let(:response) { get :show }

      it 'responds with status 200' do
        expect(response).to be_ok
      end

      it 'renders template :show' do
        expect(response).to render_template(:show)
      end

      it 'assigns to @user_profile' do
        expect(assigns(:user_profile)).to eq(@user_profile)
      end
    end

    describe 'PUT #update /user_profile' do
      context 'with valid params' do
        before(:each) { put :update, user_profile: attributes_for(:user_profile, name: 'A new Name') }

        it 'responds with status 200' do
          expect(response).to be_ok
        end

        it 'renders template :show' do
          expect(response).to render_template(:show)
        end

        it 'sets the flash' do
          expect(flash[:notice]).not_to be_nil
        end
      end

      context 'with validation errors' do
        before(:each) { put :update, user_profile: attributes_for(:user_profile, name: '') }

        it 'responds with status 200' do
          expect(response).to be_ok
        end

        it 'renders template :show' do
          expect(response).to render_template(:show)
        end

        it 'sets the flash' do
          expect(flash[:alert]).not_to be_nil
        end
      end
    end
  end
end