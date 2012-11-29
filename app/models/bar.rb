class Bar < ActiveRecord::Base
  attr_accessible :fan_intensity_rating, :fav_team_id, :gps_coords, :name, :num_of_screens, :name, :latitude, :longitude, :team_id
  has_many  :bars_games
  has_many  :games, :through => :bars_games
  belongs_to :team 

  def self.locations(bars)
    # inject this shit dudes!
    locations_array = []
    bars.each do |bar|
      locations_array << [bar.name,bar.latitude,bar.longitude]
    end
    locations_array
  end

end
