class BarsController < ApplicationController
  respond_to :json, :html

  def new
    @bar = Bar.new
  end

  def show
    @bar = Bar.find(params[:id])
    # @games = @bar.unselected_games.includes(:home_team, :away_team).joins(:home_team, :away_team).for_week.order(:game_at)
    @games = Game.includes(:home_team, :away_team).joins(:home_team, :away_team).for_week.order(:game_at) - @bar.games
  end

  def create
    @bar = Bar.new(params[:bar])
    @bar.save!
  end

  # TODO: this method is pretty big, use private methods, or helpers to make it smaller
  # if we are nested under a game, then only show bars for that game
  # otherwise, show all bars
  def index
    if current_user && params[:my_bars]
      coordinates = current_user.bars.coordinates
    else
      coordinates = Bar.coordinates
    end 

    @markers_info = []

    # Look for AR helpers that can query by GEO
    # Bar.near(lat, lng, 2.miles)
    # Right now, we are loading all Bars, as you scale
    # check https://github.com/jlecour/geokit-rails3
    # 
    Bar.all.each do |bar|
      @bar = bar
      # we are dumping a lot of html here.  for now it's okay, but maybe we can load this on click only
      @markers_info << render_to_string(:partial => 'bars/mini_bar_info', :layout => false)
    end

    render :json => { :local_bars => coordinates, 
                      :html_marker_info => @markers_info
                    }
  end
 
  def update
    @bar = Bar.find(params[:id])
    # why Game in bars controller
    # /bars/:id/games -> means nested resource on the games controller
    @bar.games << Game.find(params[:game_ids])
    if @bar.save
      redirect_to @bar
    else
      redirect_to @bar # this is repeated, why?
    end
  end

  def destroy
    @bar = Bar.find(params[:id])
    # why are we deleting bar-games in the bar controller?
    # If you are using ajax, then it makes more sense to BarGamesController
    @bar.games.delete(Game.find(params[:game_id]))
    redirect_to @bar
  end

end

