class BarsController < ApplicationController
  respond_to :json, :html

  def index  
    
  end

  def show
    @bar = Bar.find_by_games(params[:id])
    @games = Game.includes(:home_team, :away_team).joins(:home_team, :away_team).upcoming - @bar.games
  end

  def create
    @local_bars = [['Bondi Beach', 37.7845, -122.4275],
                  ['Coogee Beach', 37.7687, -122.4757],
                  ['Cronulla Beach', 37.7946, -122.4933]]
    # @local_bars.map {|bar| []}
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

# joins(:games => [:home_team, :away_team]).includes(:games => [:home_team, :away_team]).