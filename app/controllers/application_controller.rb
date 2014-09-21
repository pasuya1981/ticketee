class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  private

    def authorize_admin!

      if current_user
        if current_user.admin
          return true
        end
      end  

      flash[:alert] = "You must be an admin to do that."
      redirect_to root_path      
    end

    def require_signin!

      if current_user.nil?
        flash[:error] = "You need to sign in or sign up before continuing."
        redirect_to signin_url
      end
    end

    def current_user
      User.find_by(id: session[:user_id]) if session[:user_id]
    end
end
