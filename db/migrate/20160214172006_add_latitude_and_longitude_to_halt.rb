class AddLatitudeAndLongitudeToHalt < ActiveRecord::Migration
  def change
    add_column :halts, :longitude, :decimal, precision: 10, scale: 7
    add_column :halts, :latitude, :decimal, precision: 10, scale: 7
  end
end
