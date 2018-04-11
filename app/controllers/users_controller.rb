class UsersController < ApplicationController

  get '/signup' do
    if !logged_in?
      erb :'users/create_user'
    else
      redirect "/users/#{current_user.slug}"
    end
  end

  post '/signup' do
    user = User.create(name: params[:name], username: params[:username], password: params[:password])
    flash[:message] = "Successfully created user account."
    session[:user_id] = user.id
    redirect "/users/#{user.slug}"
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
      redirect '/'
    end
  end

  post '/logout' do
    session.clear
    redirect '/'
  end

  get '/users/:slug' do
    if logged_in?
      @user = User.find_by_slug(params[:slug])
      if current_user == @user
        erb :'users/show'
      else
        redirect "/users/#{current_user.slug}"
      end
    else
      redirect '/'
    end
  end

end
