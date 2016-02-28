class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :name, null: false
      t.string :homepage_url, null: false
      t.string :language

      t.text :github_info

      t.timestamp :info_fetched_at

      t.timestamps
    end
  end
end
