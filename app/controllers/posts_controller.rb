class PostsController < ApplicationController
    #before_action :set_post, only: [:show, :destroy, :add_comment, :like]
    #before_action :set_current_user
  


    # GET /posts/1

    def like_count
        likes.count
    end

    def show



        @post = Post.find(params[:id])
        #likes = @post.likes
        # @comments = @post.comments.as_json(includes: :likes)
        #render :json => @comments


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

    # POST /posts/1/comments
    def add_comment
      @comment = @post.comments.new(comment_params)
      @comment.user = current_user
      if @comment.save
        redirect_to @post, notice: 'Comment was successfully added.'
      else
        render :show
      end
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

    def comment_params
      params.permit(:comment, :post_id, :user_id)
    end
  end
