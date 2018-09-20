class UserMailer < ApplicationMailer
  def new_offer
    @offer = Offer.find params[:offer_id]
    @ann = @offer.announcement
    mail from: "admin@example.com",
         to: @ann.user.email,
         subject: "'#{@ann.title}' ilanınıza yeni teklif var"
  end

  def get_your_own_account
    @announcement = Announcement.find params[:announcement_id]
    @subscriber = Subscriber.find params[:subscriber_id]
    @token = params[:token]

    mail from: Rails.application.credentials[Rails.env.to_sym][:emails][:info],
         to: @subscriber.user.email,
         subject: "#{Rails.application.credentials[:production][:domain]} - Yeni talep var"
  end
end
