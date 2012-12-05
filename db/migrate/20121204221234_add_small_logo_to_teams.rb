class AddSmallLogoToTeams < ActiveRecord::Migration
  def change
    add_column :teams, :small_logo_path, :string
  end
end
