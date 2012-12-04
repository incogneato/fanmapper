class Game < ActiveRecord::Base
  attr_accessible :away_team_id, :game_at, :home_team_id, :home_team, :away_team  # home_team, away_team needed for seed file. Don't think it is necessary for production.
  has_many :bar_games
  has_many :bars, :through => :bar_games

  belongs_to :away_team, :class_name => "Team"
  belongs_to :home_team, :class_name => "Team"

  validate :uniqueness_of_matchup
  validates_presence_of :game_at, :home_team_id, :away_team_id

  def self.with_team(team_id)
    where("home_team_id = ? OR away_team_id = ?", team_id, team_id)
  end

  def self.for_week(week_number = nil)
    if week_number 
      week_diff = current_week - week_number
      week_start = beginning_of_nfl_week - week_diff.weeks
    else
      week_start = beginning_of_nfl_week
    end
    week_end = week_start + 1.week
    where(:game_at => week_start..week_end)
  end

  def self.current_week
    DateTime.now.cweek - 35  # this will need to be recalculated for the 2013 football season
  end

  def teams
    [self.home_team, self.away_team]
  end

private

  def uniqueness_of_matchup
    if self.away_team_id == self.home_team_id
      errors.add(:away_team_id, 'team cannot play itself')
    end
  end

  def self.beginning_of_nfl_week
    if DateTime.now.monday?
      Chronic.parse('next tuesday')
    elsif DateTime.now.tuesday?
      Time.now
    else
      Chronic.parse('last tuesday')
    end
  end
end
