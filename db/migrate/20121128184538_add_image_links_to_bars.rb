class AddImageLinksToBars < ActiveRecord::Migration
  def change
    add_column :bars, :image_link, :string
  end
end
