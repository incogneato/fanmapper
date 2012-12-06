require 'spec_helper'
gem 'simplecov'
SimpleCov.start

describe Game do 

  describe 'valid matchup' do

    it 'has different home and away team' do 
      game = Game.new(:home_team_id => 1, :away_team_id => 1)
      game.should_not be_valid
    end

    it 'has presence of game_at' do
      game = Game.new(:home_team_id => 1, :away_team_id => 2)
      game.should_not be_valid
    end

    it 'has presence of home team and away team' do
      game = Game.new(:game_at => DateTime.now, :home_team_id => 1)
      game2 = Game.new(:game_at => DateTime.now, :away_team_id => 1)

      game.should_not be_valid
      game2.should_not be_valid
    end
  end

  describe '.current_week' do
    it 'only includes games for upcoming week from today' do
      game = create(:game, :game_at => DateTime.now + 1.week)
      game2 = create(:game, :game_at => DateTime.now + 1.hour)
      Game.upcoming.should_not include(game)
      Game.upcoming.should include(game2)
    end
  end

  describe '.with_team' do
    it 'returns all home and away games for team' do
      game1 = create(:game, :home_team_id => 1 )
      game2 = create(:game, :away_team_id => 1 )
      games = Game.with_team(game1.home_team_id)
      games.length.should eq(2)
    end

  end
end