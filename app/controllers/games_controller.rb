class GamesController < ApplicationController
respond_to :json, :html
  
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

  def index
    @week = if params[:week]
      params[:week].to_i
    else
      Game.current_week
    end
    @games = Game.for_week(@week)
    respond_to do |format|
      format.json { render :json => { :weekly_games => @games, :week => @week } }
      format.js    # index.js.erb
    end
  end

end