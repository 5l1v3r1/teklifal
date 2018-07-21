class CarAnnouncementSubscriptionPolicy < SubscriptionPolicy

  private

  def attributes
    [{ filter: [:make] }]
  end
  
end