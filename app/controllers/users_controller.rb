class UsersController < ApplicationController

  #If a user is not logged in, renders the signup form. Otherwise, redirects the user to their show page.
  get '/signup' do
    if !logged_in?
      erb :'users/create_user'
    else
      redirect "/users/#{current_user.slug}"
    end
  end

  #Handles the data entered by the user in the signup form
  post '/signup' do

    #Checks to see if a user already exists with the username entered. If so, redirects user to the signup page and renders error message.
    if User.find_by(username: params[:username])
      flash[:message] = "Username already exists. Please pick a new username or go to login if that is your account."
      redirect '/signup'

    #If above condition fails, creates a new user, logs them in (by setting their ID as the value of user_id in the session hash), and redirects them to their user show page, rendering a success message.
    else
      user = User.create(name: params[:name], username: params[:username], password: params[:password])
      session[:user_id] = user.id
      flash[:message] = "You've successfully created your account!"
      redirect "/users/#{user.slug}"
    end
  end

  #If a user is not logged in, renders the login form. Otherwise, redirects user to the user's show page.
  get '/login' do
    if !logged_in?
      erb :'users/login'
    else
      redirect "/users/#{current_user.slug}"
    end
  end

  #Handles the data entered by the user in the login form.
  post '/login' do
    user = User.find_by(username: params[:username])

    #Checks to see if a user with the entered username exists and checks that the password entered is correct. If so, logs that user in and redirects them to their user show page.
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect "/users/#{user.slug}"

    #If above condition fails, redirects user to the site landing page and renders error message.
    else
      flash[:message] = "I'm sorry, we could not find an account with the username and password you entered. Please try again."
      redirect '/'
    end
  end

  #Logs the user out (by clearing the session hash) and redirects them to the site landing page.
  get '/logout' do
    session.clear
    redirect '/'
  end

  #Checks if current user is the admin user and, if so, renders the users index page, which shows a list of all users of the application. Otherwise, redirects the user to the site landing page.
  get '/users' do
    if current_user.username == "admin"
      @users = User.all
      erb :'users/index'
    else
      redirect '/'
    end
  end

  #Renders a user show page or redirects user to the site landing page.
  get '/users/:slug' do

    #Checks to see if user is logged in and if so, finds the user by the slug in the params and sets it as the value to the @user variable.
    if logged_in?
      @user = User.find_by_slug(params[:slug])

      #Checks to see if the current user matches the @user variable or if the current user is the admin user. If so, renders the user show page for @user.
      if current_user == @user || current_user.username == "admin"
        erb :'users/show'

      #If above condition fails, redirects user to their own show page.
      else
        redirect "/users/#{current_user.slug}"
      end

    #If user not logged in, redirects to site landing page.
    else
      redirect '/'
    end
  end

  #Allows for deleting a user account.
  get '/users/:slug/delete' do
    @user = User.find_by_slug(params[:slug])

    #Checks to see if the current user is the admin user. If so, deletes the user account found by the :slug from params. Redirects user to the users index page and renders success message.
    if current_user.username == "admin"
      @user.destroy
      flash[:message] = "#{@user.username}'s account has been deleted."
      redirect '/users'

    #Checks to see if the current user matches the user found by the :slug in the params. If so, logs them out, deletes their account, and redirects them to the site landing page and renders a success message.
    elsif current_user == @user
      session.clear
      @user.destroy
      flash[:message] = "Your account has been deleted. We're sorry to see you go!"
      redirect '/'

    #If the above conditions fail, redirects user to the site landing page.
    else
      redirect '/'
    end
  end

end
