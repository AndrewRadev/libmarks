class AddProjectIdToUserBookmarks < ActiveRecord::Migration
  def change
    add_column :user_bookmarks, :project_id, :integer
    add_index :user_bookmarks, :project_id
  end
end
