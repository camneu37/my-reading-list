require 'bundler'
Bundler.require

ActiveRecord::Base.establish_connection(
  :adapter => "sqlite3",
  :database => "db/my_reading_list.sqlite"
)

require 'sinatra'
require 'active_record'

require_all 'app'
