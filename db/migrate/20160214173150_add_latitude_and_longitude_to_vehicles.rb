class AddLatitudeAndLongitudeToVehicles < ActiveRecord::Migration
  def change
    add_column :vehicles, :latitude, :decimal, precision: 10, scale: 7
    add_column :vehicles, :longitude, :decimal, precision: 10, scale: 7
  end
end
