class GamesController < ApplicationController

  def index
    @games = Game.weekly_games
  end

end