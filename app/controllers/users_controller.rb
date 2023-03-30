class UsersController < ApplicationController
    # before_action :logged_in_user, only: [:edit, :update, :destroy, :following, :followers]
    # skip_before_action [:index]
    #before_action :correct_user, only: [:edit, :update]


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


    def followers_count
      user = User.find(params[:id])
      render json: { followers_count: user.followers_count }
    end

    #follow another user

    def follow
      @user = User.find(params[:id])
      @current_user.following << @user unless @current_user.following.include?(@user)
      redirect_to @user
    end
        
    def following
       @following = User.find(params[:id]).following
       render json: @following

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


    #creating user on signup page

    def new
      @user = User.new
    end

   #creating user on signup page
    def create
      user = User.create(user_params)
      if user.valid?
        render json: user, status: :created
      else
        render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
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


  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to users_url
  end


private
  def users_params
    params.permit(:name, :profile_pic, :background_image, :bio)
  end

  def user_params
    params.permit(:name, :username, :email, :password, :password_confirmation, :bio)
  end


  end
