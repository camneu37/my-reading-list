class Book < ActiveRecord::Base
  belongs_to :author
  has_many :books_users
  has_many :users, through: :books_users
  has_many :books_genres
  has_many :genres, through: :books_genres
end
