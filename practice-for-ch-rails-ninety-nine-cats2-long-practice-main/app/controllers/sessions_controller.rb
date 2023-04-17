class SessionsController < ApplicationController

    def new
        @user = User.new
        render :new
    end

    def create
        username = params[:user][:username]
        password = params[:user][:password]

        @user = User.find_by_credentials(username, password)

        if @user
            login!(@user) # still need to write this method
            redirect_to user_url(@user)
        else
            # no errors yet
            @user = User.new(username: username)
            render :new
        end
    end

    def destroy
        logout!

        redirect_to new_session_url
    end
end