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
    user.username = Faker::Internet.username
    user.email = "#{user.username}@example.com"
    user.password = "password"
    user.private = [true, false].sample
    user.save
  end
  users = User.all
  users.each do |first_user|
    users.each do |second_user|
      if rand < 0.7
        first_user.sent_follow_requests.create(
          recipient: second_user,
          status: ["pending", "accepted", "rejected"].sample
        )
      end
    end
  end

  users.each do |user|
    [15].sample.times do
      Photo.create(
        caption: Faker::Quote.fortune_cookie,
        image: Faker::LoremFlickr.image,
        owner_id: user.id
      )
    end
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

  p "Create 12 users, photos, comments, likes and follow requests"

end
