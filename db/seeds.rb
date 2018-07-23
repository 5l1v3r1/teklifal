# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
if Rails.env.development?
  require 'faker'
  require 'random_point'

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

    [user, subscriber]
  end

  def create_car_announcement_subsription subscriber
    subscription = subscriber.subscriptions.new.tap do |s|
      s.type = "CarAnnouncementSubscription"
      s.filter = {
        make: CarAnnouncement::BRANDS[rand(0..(CarAnnouncement::BRANDS.count-1))]
      }
      s.save
    end
  end

  istanbul_yesilkoy_airport = {
    longitude: 28.81991740000001,
    latitude: 40.9798657
  }

  ankara_asti = {
    longitude: 32.814464300000054,
    latitude: 39.9181567
  }

  def create_car_rental_announcement_subsription subscriber, center
    random_point = RandomPoint.generate_from_center_point center: center, radius: 5000

    subscription = subscriber.subscriptions.new.tap do |s|
      s.type = "CarRentalAnnouncementSubscription"
      s.filter = {
        location: "Eskişehir",
        latitude: random_point[:latitude],
        longitude: random_point[:longitude],
      }
      s.save
    end
  end

  # (CarAnnouncement::BRANDS.size * 10).times do
  #   puts create_user![2].filter[:make]
  # end

  Subscriber.all.each do |subscriber|
    centers = [istanbul_yesilkoy_airport, ankara_asti]
    create_car_rental_announcement_subsription subscriber, centers[rand 0..1]
  end
end