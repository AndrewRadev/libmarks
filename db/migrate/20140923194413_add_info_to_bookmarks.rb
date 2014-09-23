class AddInfoToBookmarks < ActiveRecord::Migration
  def change
    add_column :bookmarks, :info, :text
  end
end
