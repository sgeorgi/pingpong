#
# PingPong Table Model Class
#
class PingPongTable < ActiveRecord::Base
  geocoded_by :address

  validates_presence_of :street, :street_number, :postal_code, :city, blank: false

  after_validation :geocode, if: -> (obj) do
    obj.street.present? and
      obj.street_number.present? and
      obj.postal_code.present? and
      obj.city.present? and
      !obj.geocoded?
  end

  scope :for_center_and_edge, -> (_center, _edge) {

    near(_center, Geocoder::Calculations.distance_between(_center, _edge, units: :km), units: :km)
  }

  def address
    "#{street} #{street_number}, #{postal_code} #{city}"
  end
end
