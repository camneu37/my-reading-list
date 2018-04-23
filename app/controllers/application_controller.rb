class ApplicationController < Sinatra::Base
  require 'rack-flash'

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, 'strange_brew'
    use Rack::Flash
  end

  #If user not logging in, renders the landing page which prompts user to log in or sign up. Otherwise, redirects the user to their user show page.
  get '/' do
    if !logged_in?
      erb :index
    else
      redirect "/users/#{current_user.slug}"
    end
  end


  helpers do
    #checks if there is a user logged in
    def logged_in?
      !!session[:user_id]
    end

    #checks to see who the current user is
    def current_user
      @user ||= User.find_by_id(session[:user_id])
    end
  end

end
