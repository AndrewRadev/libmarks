class AddInfoFetchedAtToBookmarks < ActiveRecord::Migration
  def change
    add_column :bookmarks, :info_fetched_at, :datetime
  end
end
