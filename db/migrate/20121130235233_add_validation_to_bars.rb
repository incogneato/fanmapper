class AddValidationToBars < ActiveRecord::Migration
  def change
    change_column :bars, :address, :string, :null => false
    change_column :bars, :zip_code, :string, :null => false
    change_column :bars, :city, :string, :null => false
    change_column :bars, :state, :string, :null => false
  end
end
