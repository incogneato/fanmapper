require 'spec_helper' 


describe Team do 

  describe '.games' do

    it 'shows games for team' do
      team = Team.create(:logo_path => 'http://content.sportslogos.net', :team_name => 'Eagles', :home_city => 'Philadelphia')
      game = Game.create(:game_at => DateTime.now, :home_team_id => 1, :away_team_id => 2)
      team.games.should include(game)
    end

  end

end