class CommentsController < ApplicationController
  before_action :set_post
  #added
  def index
    post = Post.find(params[:post_id])
    comments = post.comments
    render json: comments
  end

  def create
    post = Post.find(params[:post_id])
    comment = post.comments.build(comment_params)
    if comment.save
      render json: comment, status: :created
    else
      render json: comment.errors, status: :unprocessable_entity
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end





    # def index
    #     @comments = Comment.all.order(created_at: :desc)
    #     render json: @comments
    # end

    def show
        @comments = Comment.find(params[:id])
        render json: @comments
    end

    # POST /posts/1/comments
    # def create
    #     @comment = @post.comments.new(comment_params)
    #     @comment.user = current_user
    #     if @comment.save
    #       redirect_to @post, notice: 'Comment was successfully added.'
    #     else
    #       render :show
    #     end
    # end

    def create
        @post = Post.find(params[:post_id])
        if @post.nil?
          redirect_to posts_path, alert: 'Post not found.'
          return
        end
      
        @comment = @post.comments.new(comment_params)
        @comment.user = @current_user
        if @comment.save
          redirect_to @post, notice: 'Comment was successfully added.'
        else
          render :show
        end
    end

    def update
        @comment = Comment.find(params[:id])
        if @comment.update(comment_params)
          redirect_to @comment.post, notice: 'Comment was successfully updated.'
        else
          render :edit
        end
    end

    def edit
        @comment = Comment.find(params[:id])
    end


      

    # def comment_params
    #     params.permit(:comment, :post_id, :user_id)
    # end
    def comment_params
        params.require(:comment).permit(:body, :post_id).merge(user_id: @current_user.id)
    end

end




