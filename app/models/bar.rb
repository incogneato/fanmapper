class Bar < ActiveRecord::Base
  attr_accessible :fan_intensity_rating, :fav_team_id, :gps_coords, :name, :num_of_screens
has_many  :bars_games
has_many  :games, :through => :bars_games
belongs_to :team 
end
