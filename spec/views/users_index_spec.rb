require_relative '../rails_helper'

RSpec.describe 'Users', type: :system do
  # Create some test users and their associated data
  before do
    @user1 = User.create(name: 'John Doe', photo: 'https://placehold.co/200x200',
                         bio: "Hello, I'm John Doe", posts_counter: 5)
    @user2 = User.create(name: 'Jane Doe', photo: 'https://placehold.co/200x200', bio: "Hello, I'm Jane Doe")
    @user1.posts.create(title: 'First Post', text: 'Lorem ipsum', comments_counter: 1, likes_counter: 2)
    @user1.posts.create(title: 'Second Post', text: 'Dolor sit amet')
    @user2.posts.create(title: 'Post 3', text: 'Consectetur adipiscing elit')
  end

  it 'displays user informtion on the index page' do
    visit users_path
    sleep(5)

    expect(page).to have_content(@user1.name)
    expect(page).to have_content(@user2.name)
    expect(page).to have_selector("img[src='#{@user1.photo}']")
    expect(page).to have_selector("img[src='#{@user2.photo}']")
    expect(page).to have_content('Number of posts: 2') # user1 has 2 posts
    expect(page).to have_content('Number of posts: 1') # user2 has 1 post
  end

  it "redirects to user's show page when cliked" do
    visit users_path

    find("a[id='#{@user1.id}']").click
    sleep(5)

    current_path
    expect(current_path).to eq(user_path(@user1))
    expect(page).to have_content(@user1.name)
    expect(page).to have_selector("img[src='#{@user1.photo}']")
    expect(page).to have_content('Number of posts: 2')
  end
end
