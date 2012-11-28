require 'csv'
require 'Time'

game_data = []

CSV.foreach("game_data.csv") do |row|

  unless row[0].split(",")[1].strip.gsub(/December/,"12")[4..5].to_i == 0 

    minutes = row[1].gsub(/(\w?.*?[(]|[)].*)/,"").split(":")[1][0..1]
    hour = row[1].gsub(/(\w?.*?[(]|[)].*)/,"").split(":")[0].to_i + 12

      game_data << Hash[
      #:row_1,  row[1].split("at"),
      #:size, row[1].split("at").size,
      :game_on, Time.new(2012,12,row[0].split(",")[1].strip.gsub(/December/,"12")[4..5].to_i, hour, minutes, 0, "-05:00" ),
      :away,row[1].split(" at ")[0].strip,
      :away_team,row[1].split("   ")[1].split(" at ")[0],
      :home,row[1].split(" at ")[1].split("(")[0].strip,
      :home_team,row[1].split("   ")[1].split(" at ")[1],
      :game_at,row[1].gsub(/(\w?.*?[(]|[)].*)/,"")
      ]
  end
end
# .split("  ")[1].split(" at")[0]
# 
    game_data.each do |game|
      if game[:home].include?("N.Y.")
        game[:home] = "New York"
      elsif game[:away].include?("N.Y.")
        game[:away] = "New York"
      end
    end

game_data.shift
# game_data.each do |game|
#   p game
# end

CSV.open("game_data_clean.csv", "wb") do |csv|
  game_data.each do |game|
    csv << [game[:game_on], game[:home_team], game[:away_team]]
    #p game[:home]
  end
end

#row[0].split(",")[1].strip.gsub(/December/,"12") + " 2012"

#row[0].split(",")[1].strip.gsub(/December/,"12")[1]

#[:away_team].split("   ")[1].split(" at")[0] // gets away team name

#[:home_team].split("   ")[1].split("at ")[1].split(" T")[0] // gets home team name