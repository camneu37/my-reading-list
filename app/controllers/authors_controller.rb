class AuthorsController < ApplicationController

  get '/authors' do
    if logged_in?
      @authors = Author.all
      erb :'authors/index'
    else
      redirect '/'
    end
  end

end
