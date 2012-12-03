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
    # how do we use this controller for 2 different links and choose the response
    #@my_bars = User.find(4) 
    # respond_to :json -- this throws a server error, but we don't know why
    if current_user.nil? || current_user.bar_owner == false
      @local_bars = Bar.locations(Bar.all)
      render :json => {:local_bars => @local_bars}
    elsif current_user.bar_owner?
      @local_bars = Bar.locations(current_user.bars)
      render :json => {:local_bars => @local_bars}
    end 
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

