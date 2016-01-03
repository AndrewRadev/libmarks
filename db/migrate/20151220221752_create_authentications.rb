class CreateAuthentications < ActiveRecord::Migration
  def change
    create_table :authentications do |t|
      t.references :user, null: false

      t.string :provider, null: 'false'
      t.string :token
      t.string :scope

      t.timestamps
    end

    add_foreign_key :authentications, :users
    add_index :authentications, [:user_id, :provider, :token]
  end
end
