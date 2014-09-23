class AddTimestampsToBookmarks < ActiveRecord::Migration
  def change
    add_column :bookmarks, :created_at, :datetime
    add_column :bookmarks, :updated_at, :datetime
  end
end
