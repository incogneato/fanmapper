class TeamsController < ApplicationController  
  respond_to :json

  def show
    @team = Team.find(params[:id])
    @local_bars = Bar.locations(team.bars)
    render :json => {:team => @team, :local_bars => @local_bars}
  end
end