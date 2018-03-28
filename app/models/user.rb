class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  validates :username, uniqueness: { message: "A weab already owns that Username" }, length: { minimum: 6 , message: "Username is too short" }
  validates :firstname, length: { minimum: 6 , message: "Firstname is too short"}
  validates :lastname, length: { minimum: 6 , message: "Lastname is too short"}
  validates :email, length: { minimum: 6 , message: "Email is too short"}
end
