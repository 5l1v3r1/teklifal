module Administration
  class CarAnnouncementSubscriptionsController < SubscriptionsController
    def index
      CarAnnouncementSubscription.all.tap do |s|
        if params[:subscriber_title].present?
          s = s.joins(:subscriber).where("subscribers.title LIKE ?", "%#{params[:subscriber_title]}%")
        end
        # s = s.joins(subscriber: :user).where("subscribers.users.first_name = ?", params[:subscriber_user_first_name]) if params[:subscriber_user_first_name].present?
        if params[:make].present?
          s = s.where("filter->>'make' = ?", params[:make])
        end
        @subscriptions = s
      end
    end

    private

    def content_type
      "CarAnnouncementSubscription"
    end

  end
end