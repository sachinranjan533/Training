class ApplicationController < ActionController::Base
    respond_to :html, :json
    rescue_from CanCan::AccessDenied do |exception|
        redirect_to root_url, :alert => exception.message
    end
    before_action :authenticate_user!
    # strong parameters is used to permit new fill to add into trhe database of user or any model.
    before_action :configure_permitted_parameters, if: :devise_controller?

    def after_sign_in_path_for(resource)
        if current_user.admin?
            users_path
        else
            posts_path
        end
    end

    protected

    def configure_permitted_parameters
        devise_parameter_sanitizer.permit(:user, keys: [:location,:salary,:admin])
        devise_parameter_sanitizer.permit(:account_update, keys: [:location,:salary,:admin])
    end
end