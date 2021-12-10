class ApplicationController < ActionController::Base
    rescue_from CanCan::AccessDenied do |exception|
        redirect_to root_url, :alert => exception.message
    end
    before_action :authenticate_user!
    # strong parameters is used to permit new fill to add into trhe database of user or any model.
    before_action :configure_permitted_parameters, if: :devise_controller?

    protected

    def configure_permitted_parameters
        devise_parameter_sanitizer.permit(:sign_up, keys: [:location,:salary])
        devise_parameter_sanitizer.permit(:account_update, keys: [:location,:salary])
    end
end