class CarAnnouncementsController < ContentController

  def new
    @subscriptions = if make = params[:car_announcement].try(:[], :make)
      Subscription.where(type: "CarAnnouncementSubscription")
        .where("filter->>'make' = ?", make)
        .includes(:subscriber)
    else
      Subscription.where(type: "CarAnnouncementSubscription").includes(:subscriber)
    end

    super
  end

  def create
    @subscriptions = CarAnnouncementSubscription.search(content_params)
    super
  end

  private

  def content_resource
    CarAnnouncement
  end
end
