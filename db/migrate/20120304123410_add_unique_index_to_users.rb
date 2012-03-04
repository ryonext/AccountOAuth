class AddUniqueIndexToUsers < ActiveRecord::Migration
  def change

    add_index :users, [:login_id,:provider], :unique=>true
  end
end
