class Book < ActiveRecord::Base
  belongs_to :author
  has_many :book_users
  has_many :users, through: :book_users

  extend Slugifiable::ClassMethods

  def slug
    self.title.downcase.gsub(" ", "-")
  end
end
