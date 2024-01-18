require_relative '../rails_helper'

RSpec.describe UsersController, type: :request do
  let(:user) { User.create(name: 'John Doe', photo: nil, bio: nil, posts_counter: 0) }
  let(:post) { user.posts.create(title: 'Blog Post 1', text: 'Hello, world!', comments_counter: 0, likes_counter: 0) }

  describe 'GET #index' do
    it 'returns a successful response' do
      get "/users/#{user.id}/posts"
      expect(response).to have_http_status(:success)
    end

    it 'renders the index template' do
      get "/users/#{user.id}/posts"
      expect(response).to render_template(:index)
    end

    it 'includes correct placeholder text in the response body' do
      get "/users/#{user.id}/posts"
      expect(response.body).to include('Posts for a given User')
    end
  end

  describe 'GET #show' do
    it 'returns a successful response' do
      get "/users/#{user.id}/posts/#{post.id}"
      expect(response).to have_http_status(:success)
    end

    it 'renders the show template' do
      get "/users/#{user.id}/posts/#{post.id}"
      expect(response).to render_template(:show)
    end

    it 'includes correct placeholder text in the response body' do
      get "/users/#{user.id}/posts/#{post.id}"
      expect(response.body).to include('Details for a given post')
    end
  end
end
