require 'bundler'
require 'sinatra'
require 'active_record'


Bundler.require

ActiveRecord::Base.establish_connection(
  :adapter => "sqlite3",
  :database => "db/my_reading_list.sqlite"
)

require_all 'app'
