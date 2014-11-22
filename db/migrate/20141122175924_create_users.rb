class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string "name"

      t.string   "remember_token"
      t.datetime "remember_token_expires_at"

      t.timestamps
    end
  end
end
