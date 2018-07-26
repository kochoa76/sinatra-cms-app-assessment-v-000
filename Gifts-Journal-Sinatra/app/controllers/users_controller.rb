class UsersController < ApplicationController

  get '/signup' do
    if !logged_in?
       erb :'users/signup', locals: {message: "Please sign up before you sign in"}
     else
       redirect to '/gifts/gifts'
     end

    erb :'users/signup'
  end

  post '/signup' do
    if params[:username]== "" || params[:email]== "" || params[:password]== ""
      redirect to 'users/signup'
    else
      @user = User.create(username: params[:username], email: params[:email], password: params[:password])
      @user.save
      session[:user_id]= @user.id
      redirect to '/gifts/gifts'
    end
  end 

end
