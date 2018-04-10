class Book < ActiveRecord::Base
  belongs_to :author
  has_many :book_users
  has_many :users, through: :book_users
  has_many :book_genres
  has_many :genres, through: :book_genres

  extend Slugifiable::ClassMethods
  include Slugifiable::InstanceMethods
end
