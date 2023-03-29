class LikesController < ApplicationController
    def index
        @likes = Like.all.order(created_at: :desc)
        render json: @likes
    end
end
