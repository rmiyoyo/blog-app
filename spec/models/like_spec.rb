require 'rails_helper'

RSpec.describe Like, type: :model do
  describe 'callbacks' do
    let(:user) { User.create(name: 'John Doe', photo: nil, bio: nil, posts_counter: 0) }
    let(:post) { user.posts.create(title: 'Sample Post', text: 'Hello World', comments_counter: 0, likes_counter: 0) }
    let(:like) { Like.new(author: user, post: post) }

    it 'increments the likes counter for a post after saving' do
      expect do
        like.save
      end.to change { post.reload.likes_counter }.by(1)
    end
  end
end
