class CarRentalAnnouncementPolicy < ContentPolicy

  private

  def content_attributes
    @content_attributes ||= [ :pick_up_location,
      :latitude,
      :longitude,
      :drop_off_location,
      :different_location,
      :pick_up_time,
      :drop_off_time
    ]
  end 

end