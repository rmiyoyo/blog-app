require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe 'callbacks' do
    let(:user) { User.create(name: 'John Doe', photo: nil, bio: nil, posts_counter: 0) }
    let(:post) { user.posts.create(title: 'Sample Post', text: 'Hello World', comments_counter: 0, likes_counter: 0) }
    let(:comment) { Comment.new(text: 'Awesome comment!', author: user, post: post) }

    it 'increments the comments counter for a post after saving' do
      expect do
        comment.save
      end.to change { post.reload.comments_counter }.by(1)
    end
  end
end