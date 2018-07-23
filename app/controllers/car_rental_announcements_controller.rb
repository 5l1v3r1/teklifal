class CarRentalAnnouncementsController < ContentController

  def new
    @subscriptions = Subscription.where type: "CarRentalAnnouncementSubscription"
    super
  end

  private

    def content_resource
      CarRentalAnnouncement
    end
end
