require_relative '../rails_helper'

RSpec.describe 'Post', type: :system do
  before do
    @user1 = User.create(name: 'Alice Wonderland', photo: 'https://placehold.co/200x200',
                         bio: "Hello, I'm Alice Wonderland", posts_counter: 3)
    @user2 = User.create(name: 'Bob Wonderland', photo: 'https://placehold.co/200x200', bio: "Hello, I'm Bob Wonderland")
    @post1 = @user1.posts.create(title: 'Amazing Adventures', text: 'Lorem ipsum dolor sit amet')
    @post2 = @user1.posts.create(title: 'Exploring Wonderland', text: 'Consectetur adipiscing elit')
    @comment = Comment.create(text: 'Great post!', author: @user2, post: @post1)
  end

  it 'shows details about the user on the User post index page' do
    visit user_posts_path(user_id: @user1.id)

    expect(page).to have_content(@user1.name)
    expect(page).to have_selector("img[src='#{@user1.photo}']")
    expect(page).to have_content('Total posts: 2')
  end

  it 'displays details about the post on the User post index page' do
    visit user_posts_path(user_id: @user1.id)

    expect(page).to have_content(@post1.title)
    expect(page).to have_content(@post1.text)
    expect(page).to have_content(@post2.title)
    expect(page).to have_content(@post2.text)
    expect(page).to have_content(@user2.name)
    expect(page).to have_content(@comment.text)
    expect(page).to have_content('Likes: 0')
    expect(page).to have_content('Comments: 1')
    expect(page).to have_content('Pagination')
  end

  it 'triggers a redirect on click to post show page' do
    visit user_posts_path(user_id: @user1.id)
    find("a[id='#{@post1.id}']").click

    sleep(5)
    current_path
    expect(current_path).to eq(user_post_path(user_id: @user1.id, id: @post1.id))
  end
end
