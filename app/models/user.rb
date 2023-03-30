class User < ApplicationRecord

    has_secure_password
    # has_one_attached :avatar #added for edit profile

    has_many :posts, dependent: :destroy
    has_many :likes, dependent: :destroy
    has_many :comments, dependent: :destroy

    # Follows
    has_many :active_relationships, class_name: "Follow", foreign_key: "follower_id", dependent: :destroy
    has_many :passive_relationships, class_name: "Follow", foreign_key: "followed_id", dependent: :destroy

    has_many :following, through: :active_relationships, source: :following
    has_many :followers, through: :passive_relationships, source: :follower
<<<<<<<<< Temporary merge branch 1

    validates :username, presence: true, length: {minimum: 4}, uniqueness: true
    #validates :password, presence: true, uniqueness: true

    def followers_count
        followers.count
      end

      def following_count
        following.count
      end
=========
<<<<<<< HEAD

    def followers_count
        followers.count
    end

    def following_count
        following.count
    end
=======
>>>>>>> main
>>>>>>>>> Temporary merge branch 2

end

