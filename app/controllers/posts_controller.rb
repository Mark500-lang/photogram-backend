class PostsController < ApplicationController
    before_action :set_post, only: [:show, :destroy, :add_comment, :like]

    # GET /posts
    def index
      @posts = Post.includes(:user, comments: :user).all
      render json: @posts.to_json(include: {user: {}, comments: {include: :user } })
    end

    # GET /posts/1

    def like_count
        likes.count
    end

    def show
        @post = Post.find(params[:id])
        render json: @post, include: :comments
    end

    # POST /posts
    def create
      @post = Post.new(post_params)
      #@post.user_id = params[:id] # assuming you have a 'current_user' method that returns the user in session
      if @post.save
        redirect_to @post, notice: 'Post was successfully created.'
      else
        render :new
      end
    end

     # DELETE /posts/1
     def destroy
      post = Post.find_by(id: params[:id])
      if post
        post.destroy
        head :no_content
      else
        render json: { error: "Post not found" }, status: :not_found
      end
     end


    # DELETE /posts/1
    def destroy
      @post.destroy
      redirect_to posts_url, notice: 'Post was successfully destroyed.'
    end
    
  
    # POST /posts/1/like
    def like
      @like = @post.likes.new(user: current_user)
      if @like.save
        redirect_to @post, notice: 'Post was successfully liked.'
      else
        render :show
      end
    end

    def update_comments
      post = Post.find(comment_params[:post_id])
      comments = comment_params[:comments]
      
      comments.each do |comment|
        post.comments << comment
      end
    
      render json: post
    end
    

    private

    #def set_current_user
        #@current_user = current_user
    #end

    def set_post
      @post = Post.find(params[:id])
    end

    def post_params
      params.permit(:user_id, :post_pic, :caption)
    end

    def comment_params
      params.permit(:comments, :post_id, :user_id)
    end
  end
