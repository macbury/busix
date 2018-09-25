class GeocodeStop < BaseTransaction
  step :find_stop_location
  step :geocode

  def find_stop_location(stop)
    location = StopLocation.for_stop(stop)
    location.apply_to(stop) if location
    Success(stop)
  end

  def geocode(stop)
    unless stop.location?
      result = Geokit::Geocoders::OSMGeocoder.geocode(stop.name)
      stop.update_attributes(
        location: RGeo::Geos.factory.point(result.lng, result.lat)
      ) if result
    end
    Success(stop)
  end
end
