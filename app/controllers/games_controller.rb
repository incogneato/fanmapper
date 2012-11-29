class GamesController < ApplicationController
  
  def index
    @bar   = Bar.find(params[:bar_id])
    @games = Game.where(:game_at => DateTime.now..(DateTime.now + 7.days))
  end

end