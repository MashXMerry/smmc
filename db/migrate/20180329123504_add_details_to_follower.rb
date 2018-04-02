class AddDetailsToFollower < ActiveRecord::Migration[5.1]
  def change
    add_column :followers, :friend_fname, :string
    add_column :followers, :friend_lname, :string
    add_column :followers, :friend_email, :string
  end
end
