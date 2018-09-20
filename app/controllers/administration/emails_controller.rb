module Administration
  class EmailsController < BaseController
    def new
      @announcement = Announcement.find params[:announcement_id]
      @subscriptions = CarAnnouncementSubscription.where("filter->>'make' = ?", @announcement.content.make)
    end

    def create
      @announcement = Announcement.find params[:announcement_id]

      params[:email][:subscriptions_ids].each do |id|
        subscription = Subscription.find id

        if subscription.subscriber.user.unowned?
          token = user.send(:set_reset_password_token)

          UserMailer.with(
            token: token,
            announcement_id: @announcement.id,
            subscriber_id: subscription.subscriber.id
          ).get_your_own_account.deliver_later
        else
          AnnouncementMailer.with(
            announcement_id: @announcement.id,
            subscriber_id: subscription.subscriber.id
          ).new_announcement.deliver_later
        end
      end
    end
  end
end