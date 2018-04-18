require_relative './concerns/slugifiable'

class Author < ActiveRecord::Base
  has_many :books

  extend Slugifiable::ClassMethods

  def slug
    self.name.downcase.gsub(/[^a-z1-9]+/, '-').chomp('-')
  end

end
