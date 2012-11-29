class Game < ActiveRecord::Base
  attr_accessible :away_team, :game_at, :home_team
  has_many :bar_games
  has_many :bars, :through => :bar_games

  belongs_to :away_team, :class_name => "Team"
  belongs_to :home_team, :class_name => "Team"

  def self.with_team(team_id)
    where("home_team_id = ? OR away_team_id = ?", [team_id, team_id])
  end

  def self.upcoming(window = 1.week)
    where(:game_at => DateTime.now..(DateTime.now + window))
  end

  def self.weekly_games
    @weekly_games = []
    @games = Game.where(:game_at => DateTime.now..(DateTime.now + 6.days)) 
    @games.each do |game|
      away_team = Team.find(game.away_team_id)
      home_team = Team.find(game.home_team_id)
      @weekly_games << [game.game_at, away_team.team_name, home_team.team_name]
    end
    @weekly_games 
  end

end
