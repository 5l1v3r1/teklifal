require 'faraday'

class GeocodeValidator < ActiveModel::EachValidator
  def validate_each record, attribute, value
    res = Faraday.get geocode_api_address(value)
    json = JSON.parse res.body 
    record.errors.add(attribute, "gecerli bir adres degil") unless json["status"] == "OK"
  end

  private

  def geocode_api_address location
    location = URI.encode location
    "https://maps.googleapis.com/maps/api/geocode/json?key=AIzaSyCIxAE_my2qNSdN_s5LBH06a3oTPPbLbUo&address=#{location}"
  end
end