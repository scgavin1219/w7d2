class ApplicationController < ActionController::Base
   # helper_methods :logged_in?, :current_user

    def current_user
        @curent_user||= User.find_by(session: session[:session_token])
    end

    def require_logged_in
        redirect_to new_session unless logged_in? 
    end

    def require_logged_out
        redirect_to users_url if logged_in?
    end

    def logged_in?
        !!current_user
    end

    def login(user)
        session[:session_token] = user.reset_session_token
    end

    def logout
        self.session_token = reset_session_token
        @curent_user = nil
        session[:session_token] = nil
    end
end
