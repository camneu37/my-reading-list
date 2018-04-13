class AuthorsController < ApplicationController

  get '/authors' do
    if logged_in?
      @authors = Author.all
      erb :'authors/index'
    else
      redirect '/'
    end
  end

  get '/authors/:slug' do
    if logged_in?
      @author = Author.find_by_slug(params[:slug])
      erb :'authors/show'
    else
      redirect '/'
    end
  end
end
