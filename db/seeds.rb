require 'csv'
require 'Time'
require 'Date'

#seed NFL Teams
CSV.foreach("lib/seed_data_prep/team_data_clean.csv") do |row|
  Team.create!(team_name: row[0].strip, home_city: row[1].strip)
end

#seed NFL Games
CSV.foreach("lib/seed_data_prep/game_data_clean.csv") do |row|
  home_team = Team.find_by_team_name(row[1].strip)
  away_team = Team.find_by_team_name(row[2].strip)
  Game.create!(:game_at => row[0] , :home_team => home_team, :away_team => away_team)
end

#seed NFL Team Logos
CSV.foreach("lib/seed_data_prep/team_logos.csv") do |row|
  team_name = Team.find_by_team_name(row[0].strip)
  team_name.update_attributes(:logo_path => row[1].strip)
end

#seed NFL Team marker logos
CSV.foreach("lib/seed_data_prep/team_marker_icons.csv") do |row|
  team_name = Team.find_by_team_name(row[0].strip)
  team_name.update_attributes(:marker_img_path => row[1].strip)
end

#seed Bar data
CSV.foreach("lib/seed_data_prep/bar_data_clean.csv") do |row|
  Bar.create!(name: row[0],latitude: row[1],longitude: row[2], team_id: rand(32), num_of_screens: rand(1..20), fan_intensity_rating: rand(1..10),
              image_link: row[3], address: row[4], city: row[5], state: row[6], zip_code: row[7], neighborhood: row[8])
end


#seed Bars_Games data
  (1..19).each do |x|
    bar = Bar.find(x+1)
    (rand(25)+15).times { |i| bar.games << Game.find(i+1)}
  end
