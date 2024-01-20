require_relative '../rails_helper'

RSpec.describe 'Post', type: :system do
  # Create some test users and their associated data
  before do
    @user1 = User.create(name: 'John Doe', photo: 'https://placehold.co/200x200',
                         bio: "Hello, I'm John Doe", posts_counter: 5)
    @user2 = User.create(name: 'Jane Doe', photo: 'https://placehold.co/200x200', bio: "Hello, I'm Jane Doe")
    @post1 = @user1.posts.create(title: 'First Post', text: 'Lorem ipsum')
    @post2 = @user1.posts.create(title: 'Second Post', text: 'Dolor sit amet')
    @comment = Comment.create(text: 'comment 1', author: @user2, post: @post1)
  end

  it 'displays user information on the User post index page' do
    visit user_posts_path(user_id: @user1.id)

    expect(page).to have_content(@user1.name)
    expect(page).to have_selector("img[src='#{@user1.photo}']")
    expect(page).to have_content('Number of posts: 2') # user1 has 2 posts
  end

  it 'displays post information on the User post index page' do
    visit user_posts_path(user_id: @user1.id)

    expect(page).to have_content(@post1.title)
    expect(page).to have_content(@post1.text)
    expect(page).to have_content(@post2.title)
    expect(page).to have_content(@post2.text)
    expect(page).to have_content(@user2.name)
    expect(page).to have_content(@comment.text)
    expect(page).to have_content('Likes: 0')
    expect(page).to have_content('Comments: 1') # post1 has 1 comment from user2
    expect(page).to have_content('Pagination')
  end

  it 'redirects to post show page when clicking on a post' do
    visit user_posts_path(user_id: @user1.id)
    find("a[id='#{@post1.id}']").click

    sleep(5)
    current_path
    expect(current_path).to eq(user_post_path(user_id: @user1.id, id: @post1.id))
  end
end
