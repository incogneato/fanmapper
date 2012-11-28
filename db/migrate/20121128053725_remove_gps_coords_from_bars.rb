class RemoveGpsCoordsFromBars < ActiveRecord::Migration
  def change
    remove_column :bars, :gps_coords
  end

end
