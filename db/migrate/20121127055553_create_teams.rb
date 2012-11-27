class CreateTeams < ActiveRecord::Migration
  def change
    create_table :teams do |t|
      t.string :team_name
      t.string :home_city
      t.string :logo_path

      t.timestamps
    end
  end
end
