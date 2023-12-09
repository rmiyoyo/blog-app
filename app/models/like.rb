class Like < ApplicationRecord
  belongs_to :author, foreign_key: 'author_id', class_name: 'User'
  belongs_to :post

  after_save :update_post_likes_count

  private

  def update_post_likes_count
    post.update(likes_counter: post.likes.count)
  end
end
