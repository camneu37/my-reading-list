class Genre < ActiveRecord::Base
  has_many :books_genres
  has_many :books, through: :books_genres
  has_many :authors_genres
  has_many :authors, through: :authors_genres
end
