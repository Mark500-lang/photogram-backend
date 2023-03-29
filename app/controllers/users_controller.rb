# app/controllers/users_controller.rb
class UsersController < ApplicationController
    #before_action :logged_in_user, only: [:edit, :update, :destroy, :following, :followers]
    #skip_before_action [:index]
    #before_action :correct_user, only: [:edit, :update]
  
    def index
        @users = User.paginate(page: params[:page])
        render json: @users
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
    end
  
    def new
      @user = User.new
    end
    #signup new user to database
    # def create
    #   @user = User.new(user_params)
    #   if @user.save
    #     log_in @user
    #     flash[:success] = "Welcome to the Instagram clone app!"
    #     redirect_to @user
    #   else
    #     render 'Please sign up first'
    #   end
    # end
  
    def edit
      @user = User.find(params[:id])
    end

      before_action :authenticate_user!

  def edit_profile_picture
    @user = current_user
  end

  def update_profile_picture
    @user = current_user
    if @user.update(profile_picture_params)
      redirect_to @user, notice: 'Profile picture was successfully updated.'
    else
      render :edit_profile_picture
    end
  end

  def edit_background_picture
    @user = current_user
  end

  def update_background_picture
    @user = current_user
    if @user.update(background_picture_params)
      redirect_to @user, notice: 'Background picture was successfully updated.'
    else
      render :edit_background_picture
    end
  end

  def edit_bio
    @user = current_user
  end

  def update_bio
    @user = current_user
    if @user.update(bio_params)
      redirect_to @user, notice: 'Bio was successfully updated.'
    else
      render :edit_bio
    end
  end

  def my_posts
    @posts = current_user.posts
  end

  private

  def profile_picture_params
    params.require(:user).permit(:profile_pic)
  end

  def background_picture_params
    params.require(:user).permit(:background_image)
  end

  def bio_params
    params.require(:user).permit(:bio)
  end
  
    def update
      @user = User.find(params[:id])
      if @user.update(user_params)
        flash[:success] = "Profile updated"
        redirect_to @user
      else
        render 'edit'
      end
    end
  
    def destroy
      User.find(params[:id]).destroy
      flash[:success] = "User deleted"
      redirect_to users_url
    end
  
    # def following
    #   @title = "Following"
    #   @following  = Follow.all
    #   render json: @following
    # end
  

  
    private
  
    def user_params
      params.require(:user).permit(:name, :username, :email, :password, :password_confirmation, :bio)
    end
  
    # Before filters
  
    # Confirms a logged-in user.
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
  end
  