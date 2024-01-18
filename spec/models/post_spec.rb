require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:user) { User.new(name: 'Alex Johnson', photo: nil, bio: nil, posts_counter: 0) }
  let(:post) { user.posts.create(title: 'Post 1', text: 'Hello World', comments_counter: 0, likes_counter: 0) }

  before { user.save }

  describe 'validation' do
    context 'when title is not present' do
      it 'is invalid' do
        post.title = nil
        expect(post).not_to be_valid
      end
    end

    context 'when comments_count is not a positive integer' do
      it 'is invalid' do
        post.comments_counter = -1
        expect(post).not_to be_valid
      end
    end

    context 'when likes_count is not a positive integer' do
      it 'is invalid' do
        post.likes_counter = -1
        expect(post).not_to be_valid
      end
    end
  end

  describe '#five_recent_comments' do
    before do
      @opinion1 = Comment.create(text: 'opinion 1', author: user, post: post)
      @opinion2 = Comment.create(text: 'opinion 2', author: user, post: post)
      @opinion3 = Comment.create(text: 'opinion 3', author: user, post: post)
      @opinion4 = Comment.create(text: 'opinion 4', author: user, post: post)
      @opinion5 = Comment.create(text: 'opinion 5', author: user, post: post)
      @opinion6 = Comment.create(text: 'opinion 6', author: user, post: post)
    end

    it 'should return the five most recent comments for a given post' do
      most_recent_comments = post.five_recent_comments
      expect(most_recent_comments).to eq([@opinion6, @opinion5, @opinion4, @opinion3, @opinion2])
    end
  end

  describe '#update_author_posts_count' do
    let(:article2) { user.posts.build(title: 'Post 2', text: 'Hi', comments_counter: 0, likes_counter: 0) }

    it 'Update the user posts_counter after saving' do
      expect do
        article2.save
      end.to change { user.reload.posts_counter }.by(1)
    end
  end
end
