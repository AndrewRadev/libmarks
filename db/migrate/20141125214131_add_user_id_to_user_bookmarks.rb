class AddUserIdToUserBookmarks < ActiveRecord::Migration
  class UserBookmark < ActiveRecord::Base
  end

  def change
    # We just delete all bookmarks, since it's easier at this stage
    UserBookmark.destroy_all

    add_column :user_bookmarks, :user_id, :integer, null: false
    add_index :user_bookmarks, :user_id
  end
end
