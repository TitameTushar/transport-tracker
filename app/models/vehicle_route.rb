class VehicleRoute < ActiveRecord::Base
  belongs_to :vehicle
  belongs_to :route
end
