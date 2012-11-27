class Team < ActiveRecord::Base
  attr_accessible :home_city, :logo_path, :team_name
  has_many :bars
  has_many :home_games, :as => :home_team, :class_name => "Game"
  has_many :away_games, :as => :away_team, :class_name => "Game" 

  def games
    Game.with_team(self.id)
  end
end
