class CarRentalAnnouncementsController < ContentController

  def new
    @subscriptions = CarRentalAnnouncementSubscription.all
    super
  end

  def create
    @subscriptions = CarRentalAnnouncementSubscription.search(content_params)
    super
  end

  private

    def content_resource
      CarRentalAnnouncement
    end
end
