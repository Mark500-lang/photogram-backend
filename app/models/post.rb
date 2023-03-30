class Post < ApplicationRecord
  belongs_to :user
<<<<<<< HEAD
  has_many :comments, dependent: :destroy
  accepts_nested_attributes_for :comments
  has_many :likes, dependent: :destroy
=======
  has_many :comments
  has_many :likes
>>>>>>> main
end
