class BusDetail < ApplicationRecord
  has_many :bus_routes, inverse_of: :bus_detail, dependent: :destroy
  has_many :bus_return_routes, inverse_of: :bus_detail, dependent: :destroy
  accepts_nested_attributes_for :bus_routes, reject_if: proc { |att| att["name"].blank?}, allow_destroy: true
  accepts_nested_attributes_for :bus_return_routes, reject_if: proc { |att| att["name"].blank?}, allow_destroy: true
  resourcify
  validates :name, :number, :source, :destination, presence: true

  scope :get_buses, -> (source, desti) do where('(bus_details.source_first =? AND bus_details.destination_first =?)', source, desti)
  end

  def get_geo_location
    source_first = self.source.split(",").first
    source_last = self.source.split(",").drop(1).join(",")
    destination_first = self.destination.split(",").first
    destination_last = self.destination.split(",").drop(1).join(",")
    update_attributes(source_first: source_first, source_last: source_last, destination_first: destination_first, destination_last: destination_last)
    @source = Geocoder.coordinates(self.source)
    @destination = Geocoder.coordinates(self.destination)
    update_attributes(source_lat: @source[0], source_lang: @source[1], destination_lat: @destination[0], destination_lang: @destination[1]) if @source.present? && @destination.present?
    @routes = self.bus_routes
    @routes.each do |r|
      lat_lang = Geocoder.coordinates(r.name)
      source_dis = Geocoder::Calculations.distance_between(@source, lat_lang) if @source.present? && lat_lang.present?
      destination_dis = Geocoder::Calculations.distance_between(@destination, lat_lang) if @destination.present? && lat_lang.present?
      first_name = r.name.split(",").first
      last_name = r.name.split(",").drop(1).join(",")
      r.update_attributes(first_name: first_name, last_name: last_name)
      r.update_attributes(source_distance: source_dis, destination_distance: destination_dis) if source_dis.present? && destination_dis.present?
    end
    @return_routes = self.bus_return_routes
    @return_routes.each do |r|
      lat_lang = Geocoder.coordinates(r.name)
      source_dis = Geocoder::Calculations.distance_between(@source, lat_lang) if @source.present? && lat_lang.present?
      destination_dis = Geocoder::Calculations.distance_between(@destination, lat_lang) if @destination.present? && lat_lang.present?
      first_name = r.name.split(",").first
      last_name = r.name.split(",").drop(1).join(",")
      r.update_attributes(first_name: first_name, last_name: last_name)
      r.update_attributes(source_distance: source_dis, destination_distance: destination_dis) if source_dis.present? && destination_dis.present?
    end
  end
end
