class AddFriendusernameToFollower < ActiveRecord::Migration[5.1]
  def change
    add_column :followers, :friend_name, :string
  end
end
