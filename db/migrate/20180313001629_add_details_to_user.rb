class AddDetailsToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :firstname, :string
    add_column :users, :middlename, :string
    add_column :users, :lastname, :string
    add_column :users, :contact, :integer
    add_column :users, :birthday, :date
    add_column :users, :gender, :string
  end
end
