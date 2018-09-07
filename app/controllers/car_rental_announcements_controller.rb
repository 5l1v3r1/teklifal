class CarRentalAnnouncementsController < ContentController

  def new
    @subscriptions =  if existing_announcement_for_current_user?
                        CarRentalAnnouncementSubscription.search(@ann.content)
                      elsif content_params.has_key?(:longitude) and
                            content_params.has_key?(:latitude)
                        CarRentalAnnouncementSubscription.search(content_params)
                      else
                        CarRentalAnnouncementSubscription.all
                      end
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
