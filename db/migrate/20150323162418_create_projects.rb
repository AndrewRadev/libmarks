class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :name,     null: false
      t.string :main_url, null: false

      t.references(:user)

      t.timestamps
    end
  end
end
