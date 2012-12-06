class Bar < ActiveRecord::Base
  attr_accessible :fan_intensity_rating, :fav_team_id, :gps_coords, :name, :num_of_screens, :name, :latitude, 
                  :longitude, :team_id, :image_link, :address, :city, :state, :zip_code, :neighborhood, :games_attributes

  has_many  :bar_games
  has_many  :games, :through => :bar_games
  belongs_to :user
  belongs_to :team

  accepts_nested_attributes_for :games

  validate :unique_on_address
  validates :zip_code, :format => { :with => /^\d{5}(?:[-\s]\d{4})?$/, :message => 'Thats not a valid zipcode buddy!'}
  validates_presence_of :name, :message => "You forgot your name!"
  validates_presence_of :longitude, :message => "Longitude cannot be nil"
  validates_presence_of :latitude, :message => "Latitude cannot be nil"

  def self.find_by_games(params)
    if self.find(params).games.any?
      self.joins(:games => [:home_team, :away_team]).includes(:games => [:home_team, :away_team]).find(params)
    else
      self.find(params)  
    end
  end

  def self.coordinates(game=nil)
    all.collect { |bar| bar.to_hash(game) }
  end

  def unselected_games
    if self.games.any?
      Game.where(["id NOT in (?)", self.game_ids])
    else
      Game.scoped
    end
  end

  def unique_on_address
    num_bars = Bar.where(:address => self.address, :city => self.city, :state => self.state, :zip_code => self.zip_code).length
    if num_bars > 0
      self.errors.add(:address, "Two bars cannot have the same address, city, state, and zip.")
    end
  end

  # BarGame.as_json?
  # This method knows about game.  so it is a smell.  it can be better.
  # magic method.
  def as_json()
     {
      :name => name,
      :latitude => latitude,
      :longitude => longitude,
      :team_logo => team_logo(game)
    }
  end

  def to_hash(game=nil) #figure out a way to not need bar to know about game
    {
      :name => name,
      :latitude => latitude,
      :longitude => longitude,
      :team_logo => team_logo(game)
    }
  end

  def team_logo(game)
    if team && team.playing_in?(game)
      team.marker_img_path
    else
      'assets/markers/football_marker_alt.png'
    end
  end

end
