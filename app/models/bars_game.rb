class BarsGame < ActiveRecord::Base
  belongs_to :bar
  belongs_to :game
  attr_accessible :bar_id, :game_id
end
