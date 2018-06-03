class CarRentalAnnouncementPolicy < ContentPolicy

  private

  def content_attributes
    @content_attributes ||= [ :pick_up_location,
      :drop_off_location,
      :drop_car_off_at_different_location,
      :pick_up_time,
      :drop_off_time
    ]
  end 

end