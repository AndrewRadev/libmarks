class AddSourceToBookmakrs < ActiveRecord::Migration
  def change
    add_column :bookmarks, :source, :string
  end
end
