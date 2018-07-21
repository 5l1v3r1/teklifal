class CarAnnouncementSubscription < Subscription
  validate :filter_make

  def filter
    OpenStruct.new(super || {})
  end

  private

  def filter_make
    unless CarAnnouncement::BRANDS.include? filter.make    
      errors.add(:filter)
    end
  end
end