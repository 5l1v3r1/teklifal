class AnnouncementMailer < ApplicationMailer
  def new_announcement
    @announcement = Announcement.find params[:announcement_id]
    @subscriber = Subscriber.find params[:subscriber_id]

    mail from: Rails.application.credentials[Rails.env.to_sym][:emails][:info],
         to: @subscriber.user.email,
         subject: "#{Rails.application.credentials[:production][:domain]} - Yeni talep var"
  end
end
