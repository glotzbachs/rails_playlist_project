class RegistrationsController < Devise::RegistrationsController
    
    # skip_before_action :require_login, if: :devise_controller?

    private

    def signup_params
        params.require(:user).permit(:username, :email, :password, :password_confirmation)
    end

    def account_update_params
        params.require(:user).permit(:username, :email, :password, :password_confirmation, :current_password)
    end

end
