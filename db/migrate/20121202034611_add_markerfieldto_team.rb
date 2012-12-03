class AddMarkerfieldtoTeam < ActiveRecord::Migration
  def change
    add_column :teams, :marker_img_path, :string 
  end
end
