admin = User.create!({
    username: 'admin',
    user_type: :admin,
    email: 'admin@ideaburns.com',
    password: '12345678',
    remote_photo_url: Faker::Avatar.image,
    country: 'US',
    city: 'Alaska',
    region: 'AK',
    confirmed_at: Time.now
  })
puts 'CREATED ADMIN USER: ' << admin.email

ideaburns = IdeaBurn.create!({
    name: 'IdeaBurns',
    seo_title: 'IdeaBurns - Global Online Startup Ecosystem Platform',
    video: 'http://www.youtube.com/v/ZeStnz5c2GI?fs=1&amp;autoplay=1',
    mail_from_address: 'services@ideaburns.com'
  })
puts 'CREATED SITE: ' << ideaburns.name
