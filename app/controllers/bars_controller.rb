class BarsController < ApplicationController
  respond_to :json, :html

  def new
    @bar = Bar.new
  end

  def show
    @bar = Bar.find(params[:id])
    @games = Game.includes(:home_team, :away_team).joins(:home_team, :away_team).for_week.order(:game_at) - @bar.games
  end

  def create
    @bar = Bar.new(params[:bar])
    @bar.save!
  end

  def index
    if current_user && params[:my_bars]
      coordinates = current_user.bars.coordinates
    else
      coordinates = Bar.coordinates
    end 

    @markers_info = []

    Bar.all.each do |bar|
      @bar = bar
      @markers_info << render_to_string(:partial => 'bars/mini_bar_info', :layout => false)
    end

    render :json => { :local_bars => coordinates, 
                      :html_marker_info => @markers_info
                    }
  end
 
  def update
    @bar = Bar.find(params[:id])
    @bar.games << Game.find(params[:game_ids])
    if @bar.save
      redirect_to @bar
    else
      redirect_to @bar # this is repeated, why?
    end
  end

  def destroy
    @bar = Bar.find(params[:id])
    @bar.games.delete(Game.find(params[:game_id]))
    redirect_to @bar
  end

end

