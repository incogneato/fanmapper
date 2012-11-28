class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.datetime :game_at, :null => false
      t.integer :home_team_id, :null => false
      t.integer :away_team_id, :null => false

      t.timestamps
    end

    add_index :games, :home_team_id
    add_index :games, :away_team_id
  end
end
