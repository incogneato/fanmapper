class AddAddressToBars < ActiveRecord::Migration
  def change
    add_column :bars, :address, :string
    add_column :bars, :city, :string
    add_column :bars, :state, :string
    add_column :bars, :zip_code, :string
    add_column :bars, :neighborhood, :string
  end
end
