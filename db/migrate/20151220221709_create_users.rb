class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email, null: false
      t.string :github_username
      t.string :avatar_url

      t.timestamps
    end
  end
end
