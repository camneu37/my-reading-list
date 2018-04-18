class AuthorsController < ApplicationController

  #Renders the authors index page, showing all authors that exist in the app if a user is logged in, otherwise, redirect user to site landing page.
  get '/authors' do
    if logged_in?
      @authors = Author.all
      erb :'authors/index'
    else
      redirect '/'
    end
  end

  #Renders the page for an individual author if a user is logged in, otherwise, redirect user to site landing page.
  get '/authors/:slug' do
    if logged_in?
      @author = Author.find_by_slug(params[:slug])
      erb :'authors/show'
    else
      redirect '/'
    end
  end

  #Allows the admin to delete an author entry from the application.
  get '/authors/:slug/delete' do
    @author = Author.find_by_slug(params[:slug])

    #Checks if the current user is the admin user and if the author does not have any books. If so, deletes the author from the app, redirects user to the authors index page, and flashes a success message.
    if current_user.username == "admin" && @author.books.empty?
      @author.destroy
      flash[:message] = "#{@author.name} has been deleted from the application."
      redirect "/authors"

    #Checks if current user is the admin user and if the author has books. If so, redirects user to that author's show page and flashes an error message
    elsif current_user.username == "admin" && !@author.books.empty?
      flash[:message] = "#{@author.name} cannot be deleted from the application as they still have books in the library. All books by the author must be removed before the author can be deleted."
      redirect "/authors/#{@author.slug}"

    #if neither of the previous conditions met, redirects user to the site landing page.
    else
      redirect '/'
    end
  end
end
