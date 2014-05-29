#
# User Profile Controller
#

class UserProfilesController < ApplicationController

  before_filter :get_user_profile

  # GET #show /user_profile
  def show
  end


  # PUT #update /user_profile
  def update
    if @user_profile.update(user_profile_params)
      flash.now[:notice] = I18n.t('update_success')
    else
      flash.now[:alert] = I18n.t('update_failure')
    end

    render :show
  end

  private

  def get_user_profile
    @user_profile = current_user.user_profile
  end

  def user_profile_params
    params.require(:user_profile).permit(:name)
  end
end