class BarsController < ApplicationController
  respond_to :json, :html

  def new
    @bar = Bar.new
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

end