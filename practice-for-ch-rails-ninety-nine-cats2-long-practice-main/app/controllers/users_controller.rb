class UsersController < ApplicationController

    before_action :require_logged_out, only: [:new, :create]
    # before_action :require_logged_in
    skip_before_action :require_logged_in, only: [:new, :create]
    #, only: []

    def new
        @user = User.new
        render :new
    end

    def create
        @user = User.new(user_params)

        if @user.save
          login!(@user)
          redirect_to user_url(@user)
        else
          render json: @user.errors.full_messages, status: 422
        end
    end

    private

    def user_params
        params.require(:user).permit(:username, :password)
    end
end
