class BarsController < ApplicationController
  respond_to :json, :html

  def index  
    
  end

  def create
    @local_bars = Bar.locations
    # @local_bars = [['Bondi Beach', 37.7845, -122.4275],
    #               ['Coogee Beach', 37.7687, -122.4757],
    #               ['Cronulla Beach', 37.7946, -122.4933]]
    # @local_bars.map {|bar| []}
    render :json => {:local_bars => @local_bars}
  end
end