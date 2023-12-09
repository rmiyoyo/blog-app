class Comment < ApplicationRecord
  belongs_to :author, foreign_key: 'author_id', class_name: 'User'
  belongs_to :post
  validates_presence_of :text

  after_save :update_post_comments_count
  
  private

  def update_post_comments_count
    post.update(comments_count: post.comments.count)
  end
end
