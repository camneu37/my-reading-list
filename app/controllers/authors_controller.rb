class AuthorsController < ApplicationController

  get '/authors' do
    if logged_in?
      erb :'authors/index'
    else
      redirect '/'
    end
  end

end
