#
# PagesController to serve landing pages for AngularJS
#
class PagesController < ApplicationController

  before_action :authenticate_user!

  #
  # GET /settings
  #
  def settings
  end
end