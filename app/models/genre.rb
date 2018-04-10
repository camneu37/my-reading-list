class Genre < ActiveRecord::Base
  has_many :book_genres
  has_many :books, through: :book_genres
  has_many :author_genres
  has_many :authors, through: :author_genres

  extend Slugifiable::ClassMethods
  include Slugifiable::InstanceMethods
end
