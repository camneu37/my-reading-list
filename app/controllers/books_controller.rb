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

  post '/books' do
    author = Author.create(params[:author])
    book = Book.create(title: params[:book][:title], summary: params[:book][:summary], author_id: author.id, creator_id: session[:user_id]
    user = User.find_by_id(session[:user_id])
    user_books = user.book_ids << book.id
    user.update(book_ids: user_books)
    flash[:message] = "You've successfully created a new book. It's been added to the main library as well as your personal reading list!"
    redirect "/books/#{book.slug}"
  end

  get '/books/:slug' do
    if logged_in?
      erb :'books/show'
    else
      redirect '/'
    end
  end


  ##DO POST BOOKS ROUTE NEXT TO HANDLE CREATING A NEW BOOK THE USER ADDED!
  #Need google how to make validations for user input to ensure that bad data (aka duplicate data) isn't added. Is there a smoother way than doing find_by and each of the attributes before creating?

end
