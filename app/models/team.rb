class Team < ActiveRecord::Base
  attr_accessible :home_city, :logo_path, :team_name, :marker_img_path, :small_logo_path
  has_many :bars
  has_many :home_games, :as => :home_team, :class_name => "Game"
  has_many :away_games, :as => :away_team, :class_name => "Game" 

  def games
    Game.with_team(self.id)
  end

  def playing_in?(game)
    game && (game.home_team == self || game.away_team == self) # game && is a way to short circuit the conditional
  end
end
