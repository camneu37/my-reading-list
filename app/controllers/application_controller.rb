class ApplicationController < Sinatra::Base
  require 'rack-flash'

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, 'strange_brew'
    use Rack::Flash
  end


  get '/' do
    if !logged_in?
      erb :index
    else
      redirect "/users/#{current_user.slug}"
    end
  end


  helpers do
    def logged_in?
      !!session[:user_id]
    end

    def current_user
      @user ||= User.find_by_id(session[:user_id])
    end
  end

end
