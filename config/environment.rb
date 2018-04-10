require 'bundler'

Bundler.require
ActiveRecord::Base.establish_connection(
  :adapter => "sqlite3",
  :database => "db/my_reading_list.sqlite"
)

require_all 'app'
