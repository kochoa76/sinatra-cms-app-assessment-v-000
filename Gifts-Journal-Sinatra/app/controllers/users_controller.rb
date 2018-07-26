class UsersController < ApplicationController

  get '/users/:slug' do
   @user =User.find_by_slug(params[:slug])
   erb :'users/show'
 end

  get '/create_user' do
    if !logged_in?
       erb :'users/create_user', locals: {message: "Please sign up before you sign in"}
     else
       flash[:message] = "You need to login to view users."
       redirect to '/'
     end

    erb :'users/create_user'
  end

  post '/create_user' do
    if params[:username]== "" || params[:email]== "" || params[:password]== ""
      flash[:message] = "Please, fill in all the boxes."
      redirect to 'users/create_user'
    else
      @user = User.create(username: params[:username], email: params[:email], password: params[:password])
      @user.save
      session[:user_id]= @user.id
       flash[:message] = "You have successfully signed up."
      redirect to '/gifts/gifts'
    end
  end

  get '/login' do
    if !logged_in?
      erb :'/users/login'
    else
      redirect to '/gifts'
    end
  end

  post '/login' do
    user = User.find_by(username: params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id]= user.id
      redirect to '/gifts'
    else
      redirect to '/create_user'
    end
  end

  get '/logout' do
    if logged_in?
      session.destroy
      redirect to '/users/login'
    else
      redirect to '/'
    end
  end


end
