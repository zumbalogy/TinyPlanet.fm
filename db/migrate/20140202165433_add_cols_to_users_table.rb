class AddColsToUsersTable < ActiveRecord::Migration
  def change
    add_column :users, :username, :string
    add_column :users, :location, :string
  end
end
