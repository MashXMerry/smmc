class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  validates :username, uniqueness: { message: "already taken" }
  validates :username, length: { minimum: 6 , message: "is too short" }
  validates :firstname, length: { minimum: 3 , message: "is too short"}
  validates :lastname, length: { minimum: 6 , message: "is too short"}
  validates :email, length: { minimum: 6 , message: "is too short"}
end
