class Post < ApplicationRecord
  validates :title, presence: true
  validates :text, presence: true
  attr_accessor :comments_count
  attr_accessor :likes_count

  belongs_to :author, foreign_key: 'author_id', class_name: 'User'
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  after_save :update_author_posts_count

  def five_recent_comments
    comments.order(created_at: :desc).limit(5)
  end

  private

  def update_author_posts_count
    author.update(posts_count: author.posts.count)
  end
end