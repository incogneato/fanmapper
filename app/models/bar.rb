class Bar < ActiveRecord::Base
  attr_accessible :fan_intensity_rating, :name, :num_of_screens, :latitude, :longitude, :team_id,
                  :image_link, :address, :city, :state, :zip_code, :neighborhood, :games_attributes

  has_many  :bar_games
  has_many  :games, :through => :bar_games
  belongs_to :user
  belongs_to :team

  accepts_nested_attributes_for :games

  validates :zip_code, :format => { :with => /^\d{5}(?:[-\s]\d{4})?$/, :message => 'Thats not a valid zipcode buddy!'}
  validates :name, presence: true
  validates :longitude, presence: true
  validates :latitude, presence: true
  validates :address, uniqueness: { scope: :zip_code, case_sensitive: false }
  validates :city, presence: true
  validates :num_of_screens, :numericality => { :greater_than => 0 }

  # geocoded_by :full_address
  # before_validation :geocode, :if => :address_changed?
  # before_validation :formatted_address

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

  def formatted_address
    self.address = address.titleize.gsub(/\./, '')
    self.city = city.titleize
  end

  def full_address(country='US')
    [address, city, state, country].compact.join(', ')
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
