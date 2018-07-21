# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
if Rails.env.development?
  require 'faker'

  def create_user!
    user = User.create.tap do |u|
      u.first_name = Faker::Name.first_name
      u.last_name = Faker::Name.last_name
      u.email = Faker::Internet.email
      u.phone = (9.times.inject('5') { |str| str << rand(0..9).to_s }).to_i
      u.password = "123456"
      u.password_confirmation = "123456"
      u.save
    end

    subscriber = user.build_subscriber.tap do |s|
      s.title = Faker::Company.name
      s.subscriber_type = "firm"
      s.save
    end

    subscription = subscriber.subscriptions.new.tap do |s|
      s.type = "CarAnnouncementSubscription"
      s.filter = {
        make: CarAnnouncement::BRANDS[rand(0..(CarAnnouncement::BRANDS.count-1))]
      }
      s.save
    end

    [user, subscriber, subscription]
  end

  (CarAnnouncement::BRANDS.size * 10).times { puts create_user![2].filter[:make] }
end