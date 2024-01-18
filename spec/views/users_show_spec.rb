require_relative '../rails_helper'

RSpec.describe 'Users', type: :system do
  before do
    @user1 = User.create(name: 'Alice Wonderland', photo: 'https://placehold.co/200x200',
                         bio: "Hello, I'm Alice Wonderland", posts_counter: 5)
    @user2 = User.create(name: 'Bob Wonderland', photo: 'https://placehold.co/200x200', bio: "Hello, I'm Bob Wonderland")
    @post1 = @user1.posts.create(title: 'Amazing Adventures', text: 'Lorem ipsum')
    @post2 = @user1.posts.create(title: 'Exploring Wonderland', text: 'Dolor sit amet')
    @comment = Comment.create(text: 'Great post!', author: @user2, post: @post1)
  end

  it 'displays user information on the User show page' do
    visit user_path(id: @user1.id)
    expect(page).to have_content(@user1.name)
    expect(page).to have_content(@user1.bio)
    expect(page).to have_selector("img[src='#{@user1.photo}']")
    expect(page).to have_content('Total posts: 2')
  end

  it 'displays post information on the User show page' do
    visit user_path(id: @user1.id)
    expect(page).to have_content(@post1.title)
    expect(page).to have_content(@post1.text)
    expect(page).to have_content(@post2.title)
    expect(page).to have_content(@post2.text)
    expect(page).to have_content('See all posts')
  end

  it "redirects to post's index page when clicked on see all posts button" do
    visit user_path(id: @user1.id)
    find("a[id='view-all-posts']").click
    sleep(5)
    current_path
    expect(current_path).to eq(user_posts_path(user_id: @user1.id))
    expect(page).to have_content(@user1.name)
    expect(page).to have_selector("img[src='#{@user1.photo}']")
    expect(page).to have_content('Total posts: 2')
    expect(page).to have_content(@post1.title)
    expect(page).to have_content(@post1.text)
    expect(page).to have_content(@post2.title)
    expect(page).to have_content(@post2.text)
    expect(page).to have_content('Comments: 1') 
    expect(page).to have_content('Likes: 0')
    expect(page).to have_content(@user2.name)
    expect(page).to have_content(@comment.text)
  end

  it 'redirects to post show page when clicking on a post' do
    visit user_path(id: @user1.id)
    click_link(@post1.title)
    sleep(5)
    current_path
    expect(current_path).to eq(user_post_path(user_id: @user1.id, id: @post1.id))
  end
end
