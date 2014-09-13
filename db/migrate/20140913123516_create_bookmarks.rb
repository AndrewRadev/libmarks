class CreateBookmarks < ActiveRecord::Migration
  def change
    create_table :bookmarks do |t|
      t.string :url, null: false
      t.string :language

      t.text :data
    end
  end
end
