class CarAnnouncementsController < ContentController

  def new
    @subscriptions = Subscription.where(type: "CarAnnouncementSubscription").includes(:subscriber)
    super
  end

  private

  def content_resource
    CarAnnouncement
  end
end
