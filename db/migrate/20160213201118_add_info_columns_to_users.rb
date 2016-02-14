class AddInfoColumnsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :age, :integer
    add_column :users, :sex, :string
    add_column :users, :address, :string
    add_column :users, :work, :string
    add_column :users, :phone, :integer
  end
end
