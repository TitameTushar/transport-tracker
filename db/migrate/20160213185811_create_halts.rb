class CreateHalts < ActiveRecord::Migration
  def change
    create_table :halts do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
