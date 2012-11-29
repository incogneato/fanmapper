class Game < ActiveRecord::Base
  attr_accessible :away_team, :game_at, :home_team
  has_many :bars_games
  has_many :bars, :through => :bars_games

  belongs_to :away_team, :class_name => "Team"
  belongs_to :home_team, :class_name => "Team"

  def self.with_team(team_id)
    where("home_team_id = ? OR away_team_id = ?", [team_id, team_id])
  end

  def self.weekly_games
    @games = Game.where(:game_at => DateTime.now..(DateTime.now + 6.days))
  end

end
