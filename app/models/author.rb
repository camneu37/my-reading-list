require_relative './concerns/slugifiable'

class Author < ActiveRecord::Base
  has_many :books

  extend Slugifiable::ClassMethods
  include Slugifiable::InstanceMethods
end
