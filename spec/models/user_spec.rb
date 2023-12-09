require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { described_class.new(name: 'John Doe', photo: nil, bio: nil, posts_counter: 5) }

  before { user.save }

  describe 'validations' do
    it 'requires name to be present' do
      user.name = nil
      expect(user).not_to be_valid
    end

    it 'requires posts_counter to be a non-negative integer' do
      user.posts_counter = -1
      expect(user).not_to be_valid
    end
  end

  describe '#three_recent_posts' do
    before do
      @article1 = user.posts.create(title: 'Article 1', text: 'Hello', comments_counter: 0, likes_counter: 0)
      @article2 = user.posts.create(title: 'Article 2', text: 'Good Morning', comments_counter: 0, likes_counter: 0)
      @article3 = user.posts.create(title: 'Article 3', text: 'Bonjour', comments_counter: 0, likes_counter: 0)
      @article4 = user.posts.create(title: 'Article 4', text: 'Danke', comments_counter: 0, likes_counter: 0)
    end

    it 'returns the three most recent posts for a given user' do
      most_recent_articles = user.three_recent_posts
      expect(most_recent_articles).to eq([@article4, @article3, @article2])
    end

    it 'returns an empty array if the user has no posts' do
      user.posts.destroy_all
      most_recent_articles = user.three_recent_posts
      expect(most_recent_articles).to be_empty
    end
  end
end
