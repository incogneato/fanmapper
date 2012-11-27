class Game < ActiveRecord::Base
  attr_accessible :away_team_id, :game_at, :home_team_id
  has_many :bars_games
  has_many :bars, :through => :bars_games

  belongs_to :away_team, :class_name => "Team"
  belongs_to :home_team, :class_name => "Team"

  def self.with_team(team_id)
    where("home_team_id = ? OR away_team_id = ?", [team_id, team_id])
  end
end
