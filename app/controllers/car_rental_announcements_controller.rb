class CarRentalAnnouncementsController < ContentController

  def new
    @subscriptions =  if existing_announcement_for_current_user?
                        CarRentalAnnouncementSubscription.search(@ann.content)
                      elsif params.has_key?(content_param_name) and
                            content_params[:longitude].presence and
                            content_params[:latitude].presence
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
