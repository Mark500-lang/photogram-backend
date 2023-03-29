class User < ApplicationRecord
    has_many :posts, dependent: :destroy
    has_many :likes, dependent: :destroy
    has_many :comments, dependent: :destroy
  
    # Follows
    has_many :active_relationships, class_name: "Follow", foreign_key: "follower_id", dependent: :destroy
    has_many :passive_relationships, class_name: "Follow", foreign_key: "followed_id", dependent: :destroy
  
    has_many :following, through: :active_relationships, source: :following
    has_many :followers, through: :passive_relationships, source: :follower
  
end
