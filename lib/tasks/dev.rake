desc "Fill the database tables with some sample data"
task sample_data: :environment do
  if Rails.env.development?
    FollowRequest.destroy_all
    Comment.destroy_all
    Like.destroy_all
    Photo.destroy_all
    User.destroy_all
  end
  12.times do
    user = User.new
    user.email = Faker::Internet.email
    user.password = "password"
    user.username = Faker::Internet.username
    user.save
  end
  12.times do
    photo = Photo.new
    photo.caption = Faker::Quote.fortune_cookie
    photo.image = Faker::LoremFlickr.image
    photo.owner_id = User.all.sample.id
    photo.save
  end
  12.times do
    comment = Comment.new
    comment.body = Faker::Quote.fortune_cookie
    comment.author_id = User.all.sample.id
    comment.photo_id = Photo.all.sample.id
    comment.save
  end

  12.times do
    like = Like.new
    like.fan_id = User.all.sample.id
    like.photo_id = Photo.all.sample.id
  end

  12.times do 
    follow_request = FollowRequest.new
    users = User.all.sample(2)
    follow_request.sender_id = users[0].id
    follow_request.recipient_id = users[1].id
    follow_request.status = ["pending", "rejected", "accepted"].sample
    follow_request.save
  end

  p "Create 12 users, photos, comments, likes and follow requests"

end
