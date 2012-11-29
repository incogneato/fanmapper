class BarGame < ActiveRecord::Base
  self.table_name = 'bars_games'
  belongs_to :bar
  belongs_to :game
  attr_accessible :bar_id, :game_id
end
