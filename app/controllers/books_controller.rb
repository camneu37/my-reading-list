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
      erb :'books/create_book'
    else
      redirect '/'
    end
  end

  get '/books/new-from-author/:slug' do
    if logged_in?
      @author = Author.find_by_slug(params[:slug])
      erb :'/books/create_book_from_author'
    else
      redirect '/'
    end
  end

  post '/books' do
    if params[:author][:id].empty? && params[:author][:name].empty?
      flash[:message] = "Uh oh! It seems you forgot to add the Author's information so we could not add your book. Please try again and be sure to select the author from the dropdown or enter their name if they do not already exist. Thank you!"
      redirect '/books/new'
    elsif params[:author][:id] && !params[:author][:id].empty?
      author = Author.find_by_id(params[:author][:id])
    else
      author = Author.find_or_create_by(name: params[:author][:name])
    end
    if Book.find_by(title: params[:book][:title])
      book = Book.find_by(title: params[:book][:title])
      flash[:message] = "The book you've attempted to create already exists in our library! Click the link below to add it to your library."
      redirect "/books/#{book.slug}"
    else
      book = Book.create(title: params[:book][:title], summary: params[:book][:summary], author_id: author.id, creator_id: session[:user_id])
      book.update(user_ids: current_user.id)
      flash[:message] = "You've successfully created a new book. It's been added to the main library as well as your personal reading list!"
      redirect "/books/#{book.slug}"
    end
  end

  get '/books/:slug' do
    if logged_in?
      @book = Book.find_by_slug(params[:slug])
      erb :'books/show'
    else
      redirect '/'
    end
  end

  get '/books/:slug/edit' do
    @book = Book.find_by_slug(params[:slug])
    if logged_in? && @book.creator_id == current_user.id
      erb :'/books/edit'
    elsif current_user.username == "admin"
      erb :'/books/edit'
    else
      redirect "/books/#{@book.slug}"
    end
  end

  patch '/books/:slug' do
    book = Book.find_by_slug(params[:slug])
    author = Author.find_or_create_by(params[:author])
    book.update(title: params[:book][:title], summary: params[:book][:summary], author_id: author.id)
    flash[:message] = "You've successfully updated the entry for #{book.title}!"
    redirect "/books/#{book.slug}"
  end

  get '/books/:slug/delete' do
    @book = Book.find_by_slug(params[:slug])
    if logged_in? && current_user.username == "admin"
      @book.destroy
      flash[:message] = "#{@book.title} has been deleted from the application."
      redirect "/books"
    elsif logged_in?
      current_user.books.delete(@book)
      flash[:message] = "#{@book.title} has been removed from your Reading List."
      redirect "/users/#{current_user.slug}"
    else
      redirect '/'
    end
  end

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
