class ChangeTableOnBars < ActiveRecord::Migration
  def change
    rename_column :bars, :fav_team_id, :team_id
  end
end
