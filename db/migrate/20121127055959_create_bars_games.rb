class CreateBarsGames < ActiveRecord::Migration
  def change
    create_table :bars_games do |t|
      t.integer :bar_id
      t.integer :game_id

      t.timestamps
    end
  end
end
