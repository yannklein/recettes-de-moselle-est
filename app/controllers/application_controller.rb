class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_locale

  def configure_permitted_parameters
    # For additional fields in app/views/devise/registrations/new.html.erb
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :location, :photo])
    devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name, :location, :photo])
  end

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def default_url_options
    {
      locale: I18n.locale == I18n.default_locale ? nil : I18n.locale,
      host: ENV["DOMAIN"] || "localhost:3000"
    }
  end
end
