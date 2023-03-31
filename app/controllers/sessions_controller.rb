class SessionsController < ApplicationController
  skip_before_action :authorize, only: [:login]


  #   def new
  #   end

  # #signup
  def create
    user = User.find_by(username: user_params[:username])
    if user&.authenticate(user_params[:password])
      session[:user_id] = user.id
      render json: user, status: :created
    else
      render json: { error: "Invalid username or password" }, status: :unauthorized
    end
  end
  
   
    def new
    end


  def destroy
    session[:user_id] = nil
    redirect_to root_path, notice: 'Logged out successfully!'
  end

  private
  
  def user_params
    params.permit(:username, :password)
  end

end

