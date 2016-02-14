class AddRouteIdToVehicle < ActiveRecord::Migration
  def change
    add_reference :vehicles, :route, index: true, foreign_key: true
  end
end
