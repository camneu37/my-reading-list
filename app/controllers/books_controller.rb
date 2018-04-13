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
    book = Book.create(title: params[:book][:title], summary: params[:book][:summary], author_id: author.id, creator_id: session[:user_id])
    book.update(user_ids: current_user.id)
    flash[:message] = "You've successfully created a new book. It's been added to the main library as well as your personal reading list!"
    redirect "/books/#{book.slug}"
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
    else
      redirect "/books/#{@book.slug}"
    end
  end

  get '/books/:slug/delete' do
    if logged_in?
      @book = Book.find_by_slug(params[:slug])
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
