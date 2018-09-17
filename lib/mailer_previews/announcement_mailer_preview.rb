class AnnouncemenetMailerPreview < ActionMailer::Preview
  def new_announcement
    car_announcement = CarAnnouncement.unscoped.joins(announcement: :user).
      where.not(announcements: { users: { first_name: nil } }).where.not(make: nil).
      last

    announcement = car_announcement.announcement
    subscriber = CarAnnouncementSubscription.where("filter->>'make' = ?", car_announcement.make).last.subscriber

    AnnouncementMailer.
      with(subscriber_id: subscriber.id, announcement_id: announcement.id).
      new_announcement
  end
end