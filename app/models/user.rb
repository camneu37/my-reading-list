class User < ActiveRecord::Base
  has_many :book_users
  has_many :books, through: :book_users

  has_secure_password
  validates_presence_of :name, :username, :password

  extend Slugifiable::ClassMethods

  def slug
    self.username.downcase.gsub(/[^a-z1-9]+/, '-').chomp('-')
  end


end
