class Comment < ApplicationRecord
  belongs_to :author, foreign_key: 'author_id', class_name: 'User'
  belongs_to :post, foreign_key: 'post_id'

  after_save :update_post_comments_count
  
  private

  def update_post_comments_count
    post.update(comments_counter: post.comments.count)
  end
end
