class AddDefaultToBarsImage < ActiveRecord::Migration
  def change
    change_column :bars, :image_link, :string, :default => 'https://www.filepicker.io/api/file/XtYfCwzlSiqpJNiMpjKP'
  end
end
