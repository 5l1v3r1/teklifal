class CarAnnouncementsController < ContentController

  def new
    @subscriptions = Subscription.where(type: "CarAnnouncementSubscription").includes(:subscriber)
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
