require 'rubygems'
require 'oauth'
require 'json'
require 'csv'

# YELP_YWSID = 'js5ZjZqlp20UQQauS1Q_Eg'

consumer_key    = 'gEDNJwf08XDx9tOaj13-6w'
consumer_secret = 'DTpOwGi4fDl5VH0bPL0s8CUJ2bc'
token           = 'a8KFWCpK1CT6OtPmbQLdc9XSb_1tgLm5'
token_secret    = '1-1H4SObV0PNlNs9ILKO1vYUMII'

api_host = 'api.yelp.com'

consumer = OAuth::Consumer.new(consumer_key, consumer_secret, {:site => "http://#{api_host}" })
access_token = OAuth::AccessToken.new(consumer, token, token_secret)

path = "/v2/search?term=sports+bars&location=San+Francisco"

data = JSON.parse(access_token.get(path).body)
size = data["businesses"].size

bars = []
size.times do |x|
  bars << Hash[:name,data["businesses"][x]["name"],:latitude,data["businesses"][x]["location"]["coordinate"]["latitude"],
               :longitude,data["businesses"][x]["location"]["coordinate"]["longitude"],
               :image_link,data["businesses"][x]["image_url"],:address,data["businesses"][x]["location"]["address"].join,
               :city,data["businesses"][x]["location"]["city"],:state,data["businesses"][x]["location"]["state_code"],
               :zip_code,data["businesses"][x]["location"]["postal_code"],:neighborhood,data["businesses"][x]["location"]["neighborhoods"].join('/')]
end

bars.each do |bar|
  p bar
end

CSV.open("bar_data_clean.csv", "wb") do |csv|
  bars.each do |bars|
    csv << [bars[:name], bars[:latitude],bars[:longitude],bars[:image_link], bars[:address], bars[:city], bars[:state],
            bars[:zip_code], bars[:neighborhood]]
  end
end