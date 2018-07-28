class CarRentalAnnouncementSubscription < Subscription
  GEO_FACTORY = RGeo::Geographic.spherical_factory(srid: 4326)

  validate :filter_point
  validate :filter_location

  scope :search, ->(params, distance: 5000) {
    where(%{ST_DWithin(
      ST_GeographyFromText('SRID=4326;POINT(' || (subscriptions.filter->>'longitude')::float || ' ' || (subscriptions.filter->>'latitude')::float || ')'),
      ST_GeographyFromText('SRID=4326;POINT(%f %f)'),
      %d)} % [params[:longitude], params[:latitude], distance])
  }

  private

  def filter_point
    if !filter.latitude or !filter.longitude
      errors.add(:filter)
    end
  end

  def filter_location
    unless filter.location
      errors.add(:filter)
    end
  end
end