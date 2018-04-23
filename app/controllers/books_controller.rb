class BooksController < ApplicationController

  #Renders the list of all books in app if a user is logged in, otherwise, redirect user to site landing page.
  get '/books' do
    if logged_in?
      @books = Book.all
      erb :'books/index'
    else
      redirect '/'
    end
  end

  #Renders the form for creating a new book if the user is logged in, otherwise, redirect user to site landing page.
  get '/books/new' do
    if logged_in?
      erb :'books/create_book'
    else
      redirect '/'
    end
  end

  #Renders the form for creating a new book by a specific existing author if the user is logged in, otherwise, redirect user to site landing page.
  get '/books/new-from-author/:slug' do
    if logged_in?
      @author = Author.find_by_slug(params[:slug])
      erb :'/books/create_book_from_author'
    else
      redirect '/'
    end
  end

  #Handles the data input by the user into the create book form or create book from author form.
  post '/books' do

    #Checks to see if author details were left blank by user. If true, redirects to the page for creating a new book and renders error message indicating that author info missing.
    if params[:author][:id].empty? && params[:author][:name].empty?
      flash[:message] = "Uh oh! It seems you forgot to add the Author's information so we could not add your book. Please try again and be sure to select the author from the dropdown or enter their name if they do not already exist. Thank you!"
      redirect '/books/new'

    #Checks to see if there is an 'id' key in the author hash within the params hash and that there is a value for that id key. If true, it finds the author with that ID and sets it equal to the author variable.
    elsif params[:author][:id] && !params[:author][:id].empty?
      author = Author.find_by_id(params[:author][:id])

    #If the previous two conditions are both false, a new author is created. New author object is set as the value for 'author' variable.
    else
      author = Author.find_or_create_by(name: params[:author][:name])
    end

    #Checks to see if a book already exists with the title entered by the user. If so, redirects to that book's show page.
    if Book.find_by(title: params[:book][:title])
      book = Book.find_by(title: params[:book][:title])
      flash[:message] = "The book you've attempted to create already exists in our library! Click the link below to add it to your library."
      redirect "/books/#{book.slug}"

    #If previous condition is false, creates a new book and sets the current user as the creator of the book. Adds the book to the user's reading list (by adding the current user's ID to the books user_ids). Renders the new book's show page and renders a success message.
    else
      # book = Book.create(title: params[:book][:title], summary: params[:book][:summary], author_id: author.id, creator_id: session[:user_id])
      #
      book = author.books.create(title: params[:book][:title], summary: params[:book][:summary],creator_id: session[:user_id])
      book.update(user_ids: current_user.id)
      flash[:message] = "You've successfully created a new book. It's been added to the main library as well as your personal reading list!"
      redirect "/books/#{book.slug}"
    end
  end

  #Renders the book's show page if a user is logged in, otherwise, redirect user to site landing page.
  get '/books/:slug' do
    if logged_in?
      @book = Book.find_by_slug(params[:slug])
      erb :'books/show'
    else
      redirect '/'
    end
  end

  #Renders the edit form for an existing book.
  get '/books/:slug/edit' do
    @book = Book.find_by_slug(params[:slug])

    #Checks to see if the user is logged in and if they are the creator of the book they're trying to edit. If so, renders the edit form for the book.
    if logged_in? && @book.creator_id == current_user.id
      erb :'/books/edit'

    #Checks to see if the current user is the admin user. If so, renders the edit form for the book.
    elsif current_user.username == "admin"
      erb :'/books/edit'

    #If the previous two conditions fail, does not allow the user to edit the book and instead redirects them to the show page for the book.
    else
      redirect "/books/#{@book.slug}"
    end
  end

  #Handles the data input by the user in the edit book form. Updates the book with that data and redirects the user to the books show page, rendering a success message.
  patch '/books/:slug' do
    book = Book.find_by_slug(params[:slug])
    author = Author.find_or_create_by(params[:author])
    book.update(title: params[:book][:title], summary: params[:book][:summary], author_id: author.id)
    flash[:message] = "You've successfully updated the entry for #{book.title}!"
    redirect "/books/#{book.slug}"
  end

  #Allows for a book to be deleted from the application or from a users reading list.
  get '/books/:slug/delete' do
    @book = Book.find_by_slug(params[:slug])

    #Checks to see if the user is logged in and if the current user is the admin user. If true, deletes the book entry and redirects the user to the books index page and renders a success message.
    if logged_in? && current_user.username == "admin"
      @book.destroy
      flash[:message] = "#{@book.title} has been deleted from the application."
      redirect "/books"

    #Checks to see if the user is logged in. If so, deletes the book from the users books and redirects the user to their user show page, rendering a success message.
    elsif logged_in?
      current_user.books.delete(@book)
      flash[:message] = "#{@book.title} has been removed from your Reading List."
      redirect "/users/#{current_user.slug}"

    #If the above conditions fail, redirects to the site landing page.
    else
      redirect '/'
    end
  end

  #If a user is logged in, allows them to add a book to their books then redirects them to their user show page and renders a success message. Otherwise, redirects user to the site landing page.
  get '/books/:slug/add' do
    if logged_in?
      @book = Book.find_by_slug(params[:slug])
      @book.users << current_user
      @book.save
      flash[:message] = "#{@book.title} has been added to your Reading List."
      redirect "/users/#{current_user.slug}"
    else
      redirect '/'
    end
  end

end
