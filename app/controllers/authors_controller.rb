class AuthorsController < ApplicationController

  #renders the list of authors that exist in the app, if a user is logged in, otherwise, redirect user to site landing page
  get '/authors' do
    if logged_in?
      @authors = Author.all
      erb :'authors/index'
    else
      redirect '/'
    end
  end

  #renders the page for an individual author if a user is logged in, otherwise, redirect user to site landing page
  get '/authors/:slug' do
    if logged_in?
      @author = Author.find_by_slug(params[:slug])
      erb :'authors/show'
    else
      redirect '/'
    end
  end
end
