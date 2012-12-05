class GamesController < ApplicationController
  respond_to :json, :html
  
  # this method is long.
  # Try to DRY this up w/ bars#index
  # returns json for bars...
  # /games/id/bars.json, # nested route
  # /bars.json  # => shallow route
  def show
    game = Game.find(params[:id])
    game_bar_list = game.bars

    @markers_info = []

    game_bar_list.each do |bar|
      @bar = bar
      @markers_info << render_to_string(:partial => 'bars/mini_bar_info', :layout => false)
    end
    render :json => { :local_bars => game_bar_list.coordinates(game),
                      :html_marker_info => @markers_info
                    }
  end

  # /games  => The games resource
  # RESTFUL = different representations
  # /games.html  => webpage that lists all games
  # /games.json => { :name => "Game 1"}
  # /games.js => give me the javascript representation
  def index
    @week = if params[:week]
      params[:week].to_i
    else
      Game.current_week
    end
    @games = Game.for_week(@week)
    respond_to do |format|
      format.js    # index.js.erb
    end
  end

end