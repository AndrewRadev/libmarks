class CreateProjectConnections < ActiveRecord::Migration
  def change
    create_table :project_connections do |t|
      t.references :user, null: false
      t.references :project, null: false

      # enum
      t.integer :relationship_type, null: false, default: 0

      t.timestamps

      t.foreign_key :users
      t.foreign_key :projects

      t.index [:user_id, :project_id], unique: true
    end
  end
end
