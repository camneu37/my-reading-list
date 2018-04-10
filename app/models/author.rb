class Author < ActiveRecord::Base
  has_many :books
  has_many :author_genres
  has_many :genres, through: :author_genres

  extend Slugifiable::ClassMethods
  include Slugifiable::InstanceMethods
end
