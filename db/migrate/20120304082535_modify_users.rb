class ModifyUsers < ActiveRecord::Migration
  def up
    add_column :users, :login_id, :string
    add_column :users, :hashed_password, :string
    add_column :users, :salt, :string
  end

  def down
  end
end
