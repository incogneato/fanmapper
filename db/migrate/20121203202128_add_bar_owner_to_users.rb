class AddBarOwnerToUsers < ActiveRecord::Migration
  def change
    add_column :users, :bar_owner, :boolean, :default => false
  end
end
