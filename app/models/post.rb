class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  accepts_nested_attributes_for :comments
  has_many :likes, dependent: :destroy





  def likes_count
    likes.count
  end


end
