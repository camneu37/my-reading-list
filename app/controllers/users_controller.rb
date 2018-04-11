class UsersController < ApplicationController

  get '/signup' do
    erb :'users/create_user'
  end

  post '/signup' do
    user = User.create(name: params[:name], username: params[:username], password: params[:password])
    flash[:message] = "Successfully created user account."
    redirect "/users/#{user.username.slug}"
  end

  get '/login' do
    erb :'users/login'
  end

  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    erb :'users/show'
  end

end
