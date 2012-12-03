FactoryGirl.define do
  factory :game do
    game_at DateTime.now
    away_team_id {rand(15) + 1}
    home_team_id {rand(15) + 16}
  end
end
