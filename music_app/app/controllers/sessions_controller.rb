class SessionsController < ApplicationRecord
    def create
        @user = User.find_by_credentials(params[:user][:username], params[:user][:password])
        if @user.logged_in?
            redirect_to user_url(@user)
        else
            render :new
        end
    end

    def destroy 
        logout
        redirect_to new_user_url
    end

    



end