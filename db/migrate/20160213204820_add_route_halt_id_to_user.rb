class AddRouteHaltIdToUser < ActiveRecord::Migration
  def change
    add_reference :users, :route_halt, index: true, foreign_key: true
  end
end
