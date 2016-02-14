class CreateVehicles < ActiveRecord::Migration
  def change
    create_table :vehicles do |t|
      t.string :registration_number
      t.integer :capacity

      t.timestamps null: false
    end
  end
end
