class GamesController < ApplicationController

  def index
    @games = Game.weekly_games
    respond_to do |format|
      format.json { render :json => { :weekly_games => @games } }
      format.js    # index.js.erb
    end
  end

end