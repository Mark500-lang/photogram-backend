class SessionsController < ApplicationController
<<<<<<<<< Temporary merge branch 1
  # skip_before_action :authorize, only: [:login]


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
=========
<<<<<<< HEAD

    #signup
    def create
      user = User.find_by(username: user_params[:username])
      if user&.authenticate(user_params[:password])
        session[:user_id] = user.id
        render json: user, status: :created
      else
        render json: { error: "Invalid username or password" }, status: :unauthorized
=======
    def new
    end

    def create
      user = User.find_by(username: params[:username])
      if user && user.authenticate(params[:password_digest])
        session[:user_id] = user.id
        redirect_to root_path, notice: "Logged in!"
      else
        flash.now[:alert] = "Invalid username or password"
        render :new
>>>>>>> main
      end
>>>>>>>>> Temporary merge branch 2
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path, notice: "Logged out!"
  end

  #added

<<<<<<<<< Temporary merge branch 1

  # def create
  #   user = User.find_by(username: params[:username])

  #   if user && user.authenticate(params[:password])
  #     session[:user_id] = user.id
  #     redirect_to root_path, notice: 'Logged in successfully!'
  #   else
  #     flash.now.alert = 'Invalid username or password!'
  #     render :new
  #   end
  # end

  def destroy
    session[:user_id] = nil
    redirect_to root_path, notice: 'Logged out successfully!'
  end

  private
  def user_params
    params.permit(:username, :password)
  end

end



=========
    def destroy
      session[:user_id] = nil
      redirect_to root_path, notice: "Logged out!"
    end
<<<<<<< HEAD

    def user_params
      params.permit(:username, :password)
    end
=======
>>>>>>> main
end
>>>>>>>>> Temporary merge branch 2
