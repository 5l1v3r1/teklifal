class UserMailerPreview < ActionMailer::Preview
  def get_your_own_account
    car_announcement = CarAnnouncement.unscoped.joins(announcement: :user).
      where.not(announcements: { users: { first_name: nil } }).where.not(make: nil).
      first

    announcement = car_announcement.announcement
    subscriber = CarAnnouncementSubscription.where("filter->>'make' = ?", car_announcement.make).first.subscriber

    UserMailer.
      with(subscriber_id: subscriber.id, announcement_id: announcement.id).
      get_your_own_account
  end
end