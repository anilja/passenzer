module BusDetailsHelper

  def get_route_distance(bus)
    if bus.present? && bus.source.present? && bus.destination.present?
      @source = Geocoder.coordinates(bus.source)
      @destination = Geocoder.coordinates(bus.destination)
      dis = Geocoder::Calculations.distance_between(@source, @destination, units: :km).round(2)
      "#{dis} KM"
    else
      "Can't find distance"
    end
  end

  def get_correct_bus(source, desti)
    BusDetail.where(source_first: source, destination_first: desti).first
  end
end
