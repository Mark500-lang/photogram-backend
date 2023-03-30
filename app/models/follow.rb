class Follow < ApplicationRecord
    belongs_to :follower, class_name: 'User'
    belongs_to :following, class_name: 'User'
  
    validates :follower_id, uniqueness: { scope: :following_id }
<<<<<<< HEAD

    
    # @followed_user = User.find(params[:id])
    # current_user.followed_users << @followed_user
    # current_user.increment!(:following_count)
    # redirect_to @followed_user
    
=======
>>>>>>> main
end
