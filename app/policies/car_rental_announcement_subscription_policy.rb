class CarRentalAnnouncementSubscriptionPolicy < SubscriptionPolicy

  private

  def attributes
    [{ filter: [:location, :latitude, :longitude] }]
  end
  
end