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
    rand(15).times do
      Photo.create(
        caption: Faker::Quote.fortune_cookie,
        image: Faker::LoremFlickr.image,
        owner_id: user.id
      )
    end
  end
  photos = Photo.all


  photos.each do |photo|
    rand(5).times do
      Comment.create(
        body: Faker::Quote.fortune_cookie,
        author_id: User.all.sample.id,
        photo_id: photo.id
      )
    end

    fans = User.all.sample(rand(12))
    fans.each do |fan|
      Like.create(
        fan_id: fan.id,
        photo_id: photo.id
      )
    end
  end

  p "#{User.count} users added to database"
  p "#{FollowRequest.count} follow requests added to database"
  p "#{Photo.count} photos added to database"
  p "#{Comment.count} comments added to database"
  p "#{Like.count} likes added to database"

end
