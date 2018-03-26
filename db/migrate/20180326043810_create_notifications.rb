class CreateNotifications < ActiveRecord::Migration[5.1]
  def change
    create_table :notifications do |t|
      t.integer :user_id
      t.integer :friend_id
      t.text :content
      t.string :notif_type
      t.boolean :marked

      t.timestamps
    end
  end
end
