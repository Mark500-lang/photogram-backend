class PostsController < ApplicationController
    #before_action :set_post, only: [:show, :destroy, :add_comment, :like]
    #before_action :set_current_user


    # GET /posts
    def index
      posts = Post.all
      render json: posts, include: :comments
    end
  
    # GET /posts/1

    def like_count
        likes.count 
    end

    def show
        #@post = Post.includes(:comments, :likes).find(params[:id])

        @post = Post.find(params[:id])
        #likes = @post.likes
        render json: @post, include: :comments
        #render :json => @post
    end
      
  
    # POST /posts
    def create
      @post = Post.new(post_params)
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
  
    private

    #def set_current_user
        #@current_user = current_user
    #end
  
    def set_post
      @post = Post.find(params[:id])
    end
  
    def post_params
      params.require(:post).permit(:post_pic, :caption).merge(user: @current_user)
    end 
    
  
  end
  