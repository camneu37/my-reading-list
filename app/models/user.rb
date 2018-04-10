class User < ActiveRecord::Base
  has_many :book_users
  has_many :books, through: :book_users

  has_secure_password
  validates_presence_of :name, :username, :password
end
