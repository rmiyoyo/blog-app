require_relative '../rails_helper'

RSpec.describe 'Users', type: :system do
  before do
    @user1 = User.create(name: 'Alice Wonderland', photo: 'https://placehold.co/200x200',
                         bio: "Hello, I'm Alice Wonderland", posts_counter: 3)
    @user2 = User.create(name: 'Bob Wonderland', photo: 'https://placehold.co/200x200', bio: "Hello, I'm Bob Wonderland")
    @user1.posts.create(title: 'Amazing Adventures', text: 'Lorem ipsum', comments_counter: 1, likes_counter: 2)
    @user1.posts.create(title: 'Exploring Wonderland', text: 'Dolor sit amet')
    @user2.posts.create(title: 'Wonderful Journey', text: 'Consectetur adipiscing elit')
  end

  it 'displays user information on the index page' do
    visit users_path
    sleep(5)

    expect(page).to have_content(@user1.name)
    expect(page).to have_content(@user2.name)
    expect(page).to have_selector("img[src='#{@user1.photo}']")
    expect(page).to have_selector("img[src='#{@user2.photo}']")
    expect(page).to have_content('Total posts: 2')
    expect(page).to have_content('Total posts: 1')
  end

  it "redirects to user's show page when clicked" do
    visit users_path

    click_link(@user1.name)
    sleep(5)

    current_path
    expect(current_path).to eq(user_path(@user1))
    expect(page).to have_content(@user1.name)
    expect(page).to have_selector("img[src='#{@user1.photo}']")
    expect(page).to have_content('Total posts: 2')
  end
end
