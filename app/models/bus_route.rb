class BusRoute < ApplicationRecord
  validates :name, presence: true
  belongs_to :bus_detail, optional: true
end
