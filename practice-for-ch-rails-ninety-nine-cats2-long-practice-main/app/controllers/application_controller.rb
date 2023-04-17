class ApplicationController < ActionController::Base

    def current_user
        @current_user ||= User.find_by(session_token: session[:session_token])
    end

    helper_method :current_user


    def login!(user)
        session[:session_token] = user.reset_session_token!
    end

end
