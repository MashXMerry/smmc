class AddMiddlenameToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :username, :string
    add_column :users, :bio, :text
  end
end
