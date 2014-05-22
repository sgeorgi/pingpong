#
# PingPong Table Model Class
#
class PingPongTable < ActiveRecord::Base
  geocoded_by :address

  validates_presence_of :street, :street_number, :postal_code, :city, blank: false

  after_validation :geocode, if: -> (obj) { obj.street.present? and
    obj.street_number.present? and obj.postal_code.present? and obj.city.present? and !obj.geocoded? }

  def address
    "#{street} #{street_number}, #{postal_code} #{city}"
  end
end
