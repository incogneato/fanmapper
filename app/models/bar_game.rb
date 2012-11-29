class BarGame < ActiveRecord::Base
  self.table_name = 'bars_games'
  attr_accessible :bar_id, :game_id

  belongs_to :bar
  belongs_to :game

  validates :bar_id, :uniqueness => {:scope => :game_id}
end