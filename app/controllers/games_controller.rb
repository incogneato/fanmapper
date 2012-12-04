class GamesController < ApplicationController
respond_to :json, :html
  
  def show
    game = Game.find(params[:id])
    game_bar_list = game.bars.coordinates(game)
    render :json => {:local_bars => game_bar_list}
  end

  def index
    if params[:older]
      @games = Game.upcoming(-7)
      @week  = Time.now
    elsif params[:newer]
      @games = Game.upcoming(7)
    else 
      @games = Game.upcoming 
    end
    respond_to do |format|
      format.json { render :json => { :weekly_games => @games, :week => @week } }
      format.js    # index.js.erb
    end
  end

end