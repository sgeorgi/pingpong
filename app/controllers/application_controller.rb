#
# Main Application Controller
#
class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :set_locale

  #
  # Sets the locale, either by retrieving params[:local], setting/reading session[:locale]
  # or the default I18n.locale
  # @return nothing
  #
  def set_locale
    if params[:locale]
      I18n.locale = session[:locale] = params[:locale] || I18n.default_locale
    else
      I18n.locale = session[:locale] || I18n.default_locale
    end
  end
end
