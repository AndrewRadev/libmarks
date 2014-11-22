class CreateRegistrations < ActiveRecord::Migration
  def change
    create_table :registrations do |t|
      t.string :uid
      t.string :provider
      t.integer :user_id

      t.timestamps
    end

    add_index :registrations, [:uid, :provider]
    add_index :registrations, :user_id
  end
end
