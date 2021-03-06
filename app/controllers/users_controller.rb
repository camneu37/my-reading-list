class UsersController < ApplicationController

  get '/signup' do
    if !logged_in?
      erb :'users/create_user'
    else
      redirect "/users/#{current_user.slug}"
    end
  end

  post '/signup' do
    if User.find_by(username: params[:username])
      flash[:message] = "Username already exists. Please pick a new username or go to login if that is your account."
      redirect '/signup'
    else
      user = User.create(name: params[:name], username: params[:username], password: params[:password])
      session[:user_id] = user.id
      flash[:message] = "You've successfully created your account!"
      redirect "/users/#{user.slug}"
    end
  end

  get '/login' do
    if !logged_in?
      erb :'users/login'
    else
      redirect "/users/#{current_user.slug}"
    end
  end

  post '/login' do
    user = User.find_by(username: params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect "/users/#{user.slug}"
    else
      flash[:message] = "I'm sorry, we could not find an account with the username and password you entered. Please try again."
      redirect '/'
    end
  end

  get '/logout' do
    session.clear
    redirect '/'
  end

  get '/users' do
    if current_user.username == "admin"
      @users = User.all
      erb :'users/index'
    else
      redirect '/'
    end
  end

  get '/users/:slug' do
    if logged_in?
      @user = User.find_by_slug(params[:slug])
      if current_user == @user || current_user.username == "admin"
        erb :'users/show'
      else
        redirect "/users/#{current_user.slug}"
      end
    else
      redirect '/'
    end
  end

  get '/users/:slug/delete' do
    @user = User.find_by_slug(params[:slug])
    if current_user.username == "admin"
      @user.destroy
      flash[:message] = "#{@user.username}'s account has been deleted."
      redirect '/users'
    elsif current_user == @user
      session.clear
      @user.destroy
      flash[:message] = "Your account has been deleted. We're sorry to see you go!"
      redirect '/'
    else
      redirect '/'
    end
  end

end
