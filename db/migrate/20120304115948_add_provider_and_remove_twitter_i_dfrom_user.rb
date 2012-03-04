class AddProviderAndRemoveTwitterIDfromUser < ActiveRecord::Migration
  def up
    add_column :users, :provider, :string
    remove_column :users, :twitter_id
  end

  def down
  end
end
