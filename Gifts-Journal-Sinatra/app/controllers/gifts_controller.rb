class GiftsController < ApplicationController

  get '/gifts' do
    if logged_in?
       @gifts = Gift.all
       erb :'/gifts/gifts'
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
        @gift= current_user.gifts.build(name: params[:name], description: params[:description])
        if @gift.save
          redirect to "/gifts/#{@gift.id}"
        else
          redirect to '/gifts/create_gift'
        end
      end
    else
      redirect to '/users/login'
    end
  end

  get '/gifts/:id' do
    if logged_in?
      @gift = Gift.find_by(params[:id])
      erb :'/gifts/show_gift'
    else
      redirect to '/users/login'
    end
  end

  get '/gifts/:id/edit' do
    if logged_in?
      @gift = Gift.find_by_id(params[:id])
      if @gift && @gift.user = current_user
        erb :'gifts/edit_gift'
      else
        redirect to '/gifts'
      end
    else
      redirect to '/users/login'
    end
  end

  patch '/gifts/:id' do
    if logged_in?
      if params[:name] = "" || params[:description] = ""
        redirec to "/gifts/#{params[:id]}/edit"
      else
        @gift = Gift.find_by_id(params[:id])
        if @gift && @gift.user == current_user
          if @gift.update(params[:name], params[:description])
            redirect to "/gifts/#{@gift.id}"
          else
            redirect to "gifts/#{@gift.id}/edit"
         end
        else
          redirect to '/gifts'
         end
       end
    else
      redirect to '/users/login'
    end
  end


  get '/gifts/:id/delete' do
    if logged_in?
     @gift = Gift.find_by_id(params[:id])
     if @gift && @gift.user == current_user
       @gift.delete
     end
     redirect to '/gifts'
   else
     redirect to '/users/login'
   end
 end



end
