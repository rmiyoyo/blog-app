require_relative '../rails_helper'

RSpec.describe 'Post', type: :system do
  before do
    @user1 = User.create(name: 'John Doe', photo: 'https://placehold.co/200x200',
                         bio: "Hello, I'm John Doe", posts_counter: 5)
    @user2 = User.create(name: 'Jane Doe', photo: 'https://placehold.co/200x200', bio: "Hello, I'm Jane Doe")
    @post1 = @user1.posts.create(title: 'Post 1', text: 'Lorem ipsum')
    @comment = Comment.create(text: 'comment 1', author: @user2, post: @post1)
  end
  it 'displays post information on the User post show page' do
    visit user_post_path(user_id: @user1.id, id: @post1.id)
    expect(page).to have_content(@user1.name)
    expect(page).to have_content(@post1.title)
    expect(page).to have_content(@post1.text)
    expect(page).to have_content(@user2.name)
    expect(page).to have_content(@comment.text)
    expect(page).to have_content('Likes: 0')
    expect(page).to have_content('Comments: 1')
  end
end
