class BarsController < ApplicationController
  respond_to :json, :html

  def index  
    
  end

  def show
    @bar = Bar.find(params[:id])
  end

  def create
    @local_bars = [['Bondi Beach', 37.7845, -122.4275],
                  ['Coogee Beach', 37.7687, -122.4757],
                  ['Cronulla Beach', 37.7946, -122.4933]]
    # @local_bars.map {|bar| []}
    render :json => {:local_bars => @local_bars}
  end

  def update
    @bar = Bar.find params[:id]
    @bar.games << Game.find(params[:game_ids])
    if @bar.save
      redirect_to @bar
    else
      redirect_to @bar
    end

  end
end