class AddVehicleIdToUser < ActiveRecord::Migration
  def change
    add_reference :users, :vehicle, index: true, foreign_key: true
  end
end
