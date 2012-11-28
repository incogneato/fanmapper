class BarsController < ApplicationController
  respond_to :json, :html

  def index  
  end

  def create
    @local_bars = Bar.locations
    p params
    render :json => {:local_bars => @local_bars}
  end

  def show
    @local_bars = Bar.locations(params[:id])
    p params
    render :json => {:local_bars => @local_bars}
  end

end