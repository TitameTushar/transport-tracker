class AddDescriptionToHalt < ActiveRecord::Migration
  def change
    add_column :halts, :description, :string
  end
end
