class Bar < ActiveRecord::Base
  attr_accessible :fan_intensity_rating, :fav_team_id, :gps_coords, :name, :num_of_screens, :name, :latitude, 
                  :longitude, :team_id, :image_link, :address, :city, :state, :zip_code, :neighborhood, :games_attributes
  has_many  :bar_games
  has_many  :games, :through => :bar_games
  belongs_to :team
  accepts_nested_attributes_for :games

  def self.find_by_games(params)
    if self.find(params).games.any?
      self.joins(:games => [:home_team, :away_team]).includes(:games => [:home_team, :away_team]).find(params)
    else
      self.find(params)  
    end
  end

  def self.locations(bars)
    # inject this shit dudes!!!!!!!!!!!!!!!!!!!!!!!!!
    locations_array = []
    bars.each do |bar|
      locations_array << [bar.name,bar.latitude,bar.longitude]
    end
    locations_array
  end

end
