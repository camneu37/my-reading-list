class User < ActiveRecord::Base
  has_many :books_users
  has_many :books, through: :books_users

  has_secure_password
  validates_presence_of :name, :username, :password
end
