class CarAnnouncementsController < ContentController

  def new
    @subscriptions = Subscription.where type: "CarAnnouncementSubscription"
    super
  end

  private

  def content_resource
    CarAnnouncement
  end
end
