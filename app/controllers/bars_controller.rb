class BarsController < ApplicationController
  respond_to :json, :html

  def new
    @bar = Bar.new
  end

  def show
    @bar = Bar.find_by_games(params[:id])
    @games = Game.includes(:home_team, :away_team).joins(:home_team, :away_team).upcoming.order(:game_at) - @bar.games
  end

  def create
    @bar = Bar.new(params[:bar])
    @bar.save!
  end

  def index
    respond_to :json
    @local_bars = Bar.locations(Bar.all)
    render :json => {:local_bars => @local_bars}
  end

  def update
    @bar = Bar.find(params[:id])
    @bar.games << Game.find(params[:game_ids])
    if @bar.save
      redirect_to @bar
    else
      redirect_to @bar
    end
  end

  def destroy
    @bar = Bar.find(params[:id])
    @bar.games.delete(Game.find(params[:game_id]))
    redirect_to @bar
  end
end

