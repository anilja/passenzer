class BusReturnRoute < ApplicationRecord
  belongs_to :bus_detail, optional: true
end
