class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :twitter_id
      t.string :screen_name
      t.string :nickname
      t.datetime :last_login
      t.string :location
      t.text :profile

      t.timestamps
    end
  end
end
