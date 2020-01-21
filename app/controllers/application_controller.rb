class ApplicationController < ActionController::Base
    before_action :require_login
    skip_before_action :require_login, if: :devise_controller?
            
    def home
    end

    private

        def require_login
            unless user_signed_in?
                flash[:error] = "You must be logged in to access this page"
                redirect_to new_user_session_path
            end
        end
    
end
