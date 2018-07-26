class GiftsController < ApplicationController


  get '/gifts' do
    @gifts = Gift.all
    erb :'gifts/gifts'
  end

end
