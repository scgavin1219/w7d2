class UsersController < ApplicationController

    def new
        user = User.new
        render json: "idk"
    end

    def create
        @user = User.new(user_params)
        if @user.save
            redirect_to user_url(@user)
        else
            redirect_to new_user_url
        end 
    end

    def show
        @user = User.find_by(id: params[:id])
        render :@user.email
    end

    private
    def user_params
        params.require(:user).permit(:email, :password, :session_token)
    end
end