class BooksController < ApplicationController

  get '/books' do
    if logged_in?
      @books = Book.all
      erb :'books/index'
    else
      redirect '/'
    end
  end

  get '/books/new' do
    if logged_in?
      erb :'books/new'
    else
      redirect '/'
    end
  end

  ##DO POST BOOKS ROUTE NEXT TO HANDLE CREATING A NEW BOOK THE USER ADDED!
  #Need google how to make validations for user input to ensure that bad data (aka duplicate data) isn't added. Is there a smoother way than doing find_by and each of the attributes before creating?

end
