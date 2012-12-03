class GamesController < ApplicationController
respond_to :json, :html
  
  def show
    game = Game.find(params[:id])
    @game_bar_list = Bar.locations(game.bars, game.home_team_id, game.away_team_id)
    render :json => {:local_bars => @game_bar_list}
  end

  def index
    @games = Game.upcoming
    respond_to do |format|
      format.json { render :json => { :weekly_games => @games } }
      format.js    # index.js.erb
    end
  end

end