class CreateBars < ActiveRecord::Migration
  def change
    create_table :bars do |t|
      t.string :name
      t.float :gps_coords
      t.integer :num_of_screens
      t.integer :fan_intensity_rating
      t.integer :fav_team_id

      t.timestamps
    end
  end
end
