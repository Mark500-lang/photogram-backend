class SessionsController < ApplicationController
  skip_before_action :authorize, only: [:login]
  include ActionController::Flash

    def new
    end
  
    # def destroy
    #   session[:user_id] = nil
    #   redirect_to root_path, notice: "Logged out!"
    # end

    # def login
    #     user = User.find_by(username: params[:username])
    #     if (user && user.authenticate(params[:password]))
    #         session[:user_id] = user.id
    #         render json: {status: :created,logged_in_user: true, user: user}

    #     rescue BCrypt::Errors::InvalidHash
    #         flash[:error] = 'We recently adjusted the way our passwords are stored. Please click the "forgot username or password?" link to re-establish your password. Thank you for your understanding!'
    #         redirect_to password_resets_url
    #     # else
    #     #     render json: {errors: ["Wrong username or password"]}, status: :unauthorized
    #     end
    # end
    def login
        begin
          user = User.find_by(username: params[:username])
          if (user && user.authenticate(params[:password]))
            session[:user_id] = user.id
            render json: {status: :created, logged_in_user: true, user: user}
          else
            render json: {errors: ["Wrong username or password"]}, status: :unauthorized
          end
        rescue BCrypt::Errors::InvalidHash
          flash[:error] = 'We recently adjusted the way our passwords are stored. Please click the "forgot username or password?" link to re-establish your password. Thank you for your understanding!'
          redirect_to password_resets_url
        rescue StandardError => e
          render json: {errors: ["An error occurred while logging in: #{e.message}"]}, status: :internal_server_error
        end
      end
      

    # #logout
    def logout
        session.delete :user_id
        head :no_content
    end
end