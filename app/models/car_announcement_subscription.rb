class CarAnnouncementSubscription < Subscription
  validate :filter_make

  scope :search, ->(params) {
    where("filter->>'make' = ?", params[:make])
  }

  private

  def filter_make
    unless CarAnnouncement::BRANDS.include? filter.make    
      errors.add(:filter)
    end
  end
end