# app/controllers/users_controller.rb
class UsersController < ApplicationController
    # before_action :logged_in_user, only: [:edit, :update, :destroy, :following, :followers]
    # skip_before_action [:index]
    #before_action :correct_user, only: [:edit, :update]
<<<<<<<<< Temporary merge branch 1
    # include ActionController::Flash
=========
<<<<<<< HEAD
    def following_count
      user = User.find(params[:id])
      render json: { following_count: user.following_count }
    end

    def index
        users = User.paginate(page: params[:page])
        render json: users, include: (:following)
    end

    def show
      @user = User.find(params[:id])
      render json: @user.as_json(methods: :following_count)
=======
>>>>>>>>> Temporary merge branch 2

    def index
        @users = User.paginate(page: params[:page])
        render json: @users, include: (:following)
    end

    def followers_count
      user = User.find(params[:id])
      render json: { followers_count: user.followers_count }
    end

    def following_count
      user = User.find(params[:id])
      render json: { following_count: user.following_count }
    end

    def show
      @user = User.find(params[:id])
      render json: @user.as_json(include: :following)
      #@posts = @user.posts.paginate(page: params[:page])
      #render json: @posts
    end
    #follow another user

    def follow
      @user = User.find(params[:id])
      @current_user.following << @user unless @current_user.following.include?(@user)
      redirect_to @user
    end
    #unfollow another user
<<<<<<< HEAD
    # def unfollow
    #   @user = User.find(params[:id])
    #   @current_user.following.delete(@user) if @current_user.following.include?(@user)
    #   redirect_to @user
    # end

    # def followers
    #    @followers = User.find(params[:id]).followers
    #    render json: @followers
    # end
    def following
       @following = User.find(params[:id]).following
       render json: @following
=======
    def unfollow
      @user = User.find(params[:id])
      @current_user.following.delete(@user) if @current_user.following.include?(@user)
      redirect_to @user
    end

    #list followers
    def followers
      @followers = User.find(params[:id]).followers
      render json: @followers
    end
    #list following
    def following
      @following = User.find(params[:id]).following
      render json: @following
>>>>>>> main
    end
<<<<<<<<< Temporary merge branch 1


    #creating user on signup page
=========

    def new
      @user = User.new
    end
<<<<<<< HEAD

   #creating user on signup page
    def create
      user = User.create(user_params)
      if user.valid?
        render json: user, status: :created
      else
        render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
      end
    end



=======
>>>>>>> main
    #signup new user to database
>>>>>>>>> Temporary merge branch 2
    # def create
    #   user = User.create(user_params)
    #   if user.valid?
    #     render json: user, status: :created
    #   else
    #     render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
    #   end
    # end
    #signup new user to database
    def create
      @user = User.new(user_params)
      if @user.save
        log_in @user
        flash[:success] = "Welcome to the Instagram clone app!"
        redirect_to @user
      else
        render 'Please sign up first'
      end
    end

  def my_posts
    @posts = @current_user.posts
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(users_params)
      redirect_to @user, notice: 'Profile was successfully updated.'
    else
      render :edit
    end
  end

  def set_user
    @user = User.find(params[:id])
  end

  def logged_in_user
    unless logged_in?
      flash[:danger] = "Please log in."
      redirect_to login_url
    end
  end

  # Confirms the correct user.
  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_url) unless current_user?(@user)
  end

#   def update
#   @user = User.find(params[:id])
#   if @user.update(users_params)
#     redirect_to @user, notice: 'Profile was successfully updated.'
#   else
#     flash[:error] = @user.errors.full_messages.join(', ')
#     render :edit
#   end
# end

      @user = User.find(params[:id])
      if @user.update(user_params)
        flash[:success] = "Profile updated"
        redirect_to @user
      else
        render 'edit'
      end

    #   @title = "Following"
    #   @following  = Follow.all
    #   render json: @following
    # end


  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to users_url
  end
  private


<<<<<<<<< Temporary merge branch 1
  def users_params
    params.permit(:name, :profile_pic, :background_image, :bio)
  end

  def user_params
    params.permit(:name, :username, :email, :password, :password_confirmation, :bio)
  end

=========
    private

    def user_params
      params.require(:user).permit(:name, :username, :email, :password, :password_confirmation, :bio)
>>>>>>> main
    end
>>>>>>>>> Temporary merge branch 2

    # Before filters

    # Confirms a logged-in user.

    #added
    # def loggedin
    #   user =User.find_by(id: session[:user_id])
    #   if (user)
    #       render json: {loggedin: true, user: user}
    #   else
    #       render json: {loggedin: false}
    #   end
    # end

#signu
    # def create
    #   user = User.find_by(username: params[:username])
    #   if user&.authenticate(params[:password])
    #     session[:user_id] = user.id
    #     redirect_to root_path, notice: "Logged in!"
    #   else
    #     flash.now[:alert] = "Invalid username or password"
    #     render :new
    #   end
    # end

  end
