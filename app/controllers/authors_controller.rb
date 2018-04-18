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

  #allows the admin to delete an author entry from the application if there are no books linked to that author
  get '/authors/:slug/delete' do
    @author = Author.find_by_slug(params[:slug])
    if current_user.username == "admin" && @author.books.empty?
      @author.destroy
      flash[:message] = "#{@author.name} has been deleted from the application."
      redirect "/authors"
    elsif current_user.username == "admin" && !@author.books.empty?
      flash[:message] = "#{@author.name} cannot be deleted from the application as they still have books in the library. All books by the author must be removed before the author can be deleted."
      redirect "/authors/#{@author.slug}"
    else
      redirect '/'
    end
  end
end
