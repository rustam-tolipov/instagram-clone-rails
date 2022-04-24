class AddPostsCounterToUser < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :posts_counter, :integer, default: 0
  end
end
