$:.unshift '.'
require_relative 'config/environment'

# if ActiveRecord::Migrator.needs_migration?
#   raise 'Migrations are pending. Run "rake db:migrate" to resolve this issue.'
# end

use Rack::MethodOverride
use UsersController
use BooksController
use AuthorsController
run ApplicationController
