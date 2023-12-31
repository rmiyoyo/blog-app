# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
require 'faker'

Like.destroy_all
Comment.destroy_all
Post.destroy_all
User.destroy_all

quantity_users = 10
quantity_posts = 10
quantity_comments = 10
quantity_likes = 20
users = []

for user_position in 1..quantity_users do
  temp_user = User.create!(name: "User Number #{user_position}", photo: 'https://placehold.co/200x200', bio: Faker::Lorem.sentences(number: 12 + Random.rand(20)).join(' '), posts_counter: 0)
  users << temp_user
end

for user_position in 0..(quantity_users - 1) do
  for post_position in 0..Random.rand(quantity_posts) do
    temp_post = Post.create!(author: users[user_position], title: "Post ##{post_position + 1}", text: Faker::Lorem.sentences(number: 40 + Random.rand(100)).join(' '))
    for comment_position in 0..Random.rand(quantity_comments) do
      position = Random.rand(quantity_users)
      Comment.create!(post: temp_post, author: users[Random.rand(quantity_users)], text: Faker::Lorem.sentences(number: 12 + Random.rand(20)).join(' '))
    end
    for like in 1..Random.rand(quantity_likes) do
      Like.create!(post: temp_post, author: users[Random.rand(quantity_users)])
    end
  end
end

puts "Created #{User.count} users"
puts "Created #{Post.count} posts"
puts "Created #{Comment.count} comments"
puts "Assigned #{Like.count} likes, at random"
