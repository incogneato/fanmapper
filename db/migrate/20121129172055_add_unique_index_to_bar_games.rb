class AddUniqueIndexToBarGames < ActiveRecord::Migration
  def change
    add_index :bars_games, [:bar_id, :game_id], :unique => true
  end
end
