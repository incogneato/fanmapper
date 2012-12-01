class AddNameValidationToBars < ActiveRecord::Migration
  def change
    change_column :bars, :name, :string, :null => false
  end
end
