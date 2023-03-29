class FollowsController < ApplicationController

    def show
        @title = "Followers"
        @user  = User.find(params[:id])
        @users = @user.followers.paginate(page: params[:page])
        render 'show_follow'
    end

    def user_params
        params.require(:user)
    end


end
