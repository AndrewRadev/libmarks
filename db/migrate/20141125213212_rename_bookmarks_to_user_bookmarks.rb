class RenameBookmarksToUserBookmarks < ActiveRecord::Migration
  def change
    rename_table :bookmarks, :user_bookmarks
  end
end
