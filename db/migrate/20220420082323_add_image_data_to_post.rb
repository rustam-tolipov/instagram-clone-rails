class AddImageDataToPost < ActiveRecord::Migration[6.1]
  def change
    add_column :posts, :image_data, :text
  end
end
