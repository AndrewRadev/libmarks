class CreateProjectConnections < ActiveRecord::Migration
  def change
    create_table :project_connections do |t|
      t.references :user, null: false, index: true
      t.references :project, null: false, index: true

      # enum
      t.integer :relationship_type, null: false, default: 0

      t.timestamps

      t.foreign_key :users
      t.foreign_key :projects
    end
  end
end
