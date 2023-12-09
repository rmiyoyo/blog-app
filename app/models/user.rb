class User < ApplicationRecord
  validates :name, presence: true
  validates :photo, presence: true
  validates :bio, presence: true
  attr_accessor :posts_count

  has_many :posts, foreign_key: 'author_id', dependent: :destroy
  has_many :comments, foreign_key: 'author_id', dependent: :destroy
  has_many :likes, foreign_key: 'author_id', dependent: :destroy

  def three_recent_posts
    posts.order(created_at: :desc).limit(3)
  end
end