class GamesController < ApplicationController
respond_to :json, :html
  
  def show
    game = Game.find(params[:id])
    game_bar_list = game.bars.coordinates(game)
    render :json => {:local_bars => game_bar_list}
  end

  def index
    @games = Game.upcoming
    respond_to do |format|
      format.json { render :json => { :weekly_games => @games } }
      format.js    # index.js.erb
    end
  end

end