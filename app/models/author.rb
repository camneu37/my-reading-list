class Author < ActiveRecord::Base
  has_many :books
  has_many :authors_genres
  has_many :genres, through: :authors_genres
end
