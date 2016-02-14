class CreateRouteHalts < ActiveRecord::Migration
  def change
    create_table :route_halts do |t|
      t.references :route, index: true, foreign_key: true
      t.references :halt, index: true, foreign_key: true
      t.integer :type, default: 0

      t.timestamps null: false
    end
  end
end
