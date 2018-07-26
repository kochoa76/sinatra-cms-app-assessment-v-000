class UsersController < ApplicationController

  get '/users/signup' do
    if !logged_in?
       erb :'users/signup', locals: {message: "Please sign up before you sign in"}
     else
       redirect to '/gifts'
     end
  end

end
