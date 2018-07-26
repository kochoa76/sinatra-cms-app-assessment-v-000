class GiftsController < ApplicationController

  get '/gifts' do
    if logged_in?
       @gifts = Gift.all
       erb :'gifts/gifts'
     else
       redirect to '/login'
     end
   end

  get '/gifts/create_gift' do
    if logged_in?
      erb :'/gifts/create_gift'
    else
      erb :'/users/login'
    end
  end

  post '/gifts' do
    if logged_in?
      if params[:name] == "" || params[:description] == ""
        redirect to '/gifts/create_gift'
      else
        @gift = current_user.gifts.create(name: params[:name], description: [:description])
        if @gift.save
          redirect to '/gifts/#{@gift.id}'
        else
          redirect to '/gifts/create_gift'
        end
      end
    else
      redirect to '/users/login'
    end
  end

  

end
