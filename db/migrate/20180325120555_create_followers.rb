class CreateFollowers < ActiveRecord::Migration[5.1]
  def change
    create_table :followers do |t|
      t.integer :user_id
      t.integer :friend_id
      t.boolean :following

      t.timestamps
    end
  end
end
