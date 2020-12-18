class CollectionsController < ApplicationController
    get '/collection/:id' do
        logged_in
        @user = User.find(params[:id])
        #session[:collection_id] = @user.id
        @gems = Gemstone.where(user_id: params[:id])
        erb :"collections/show"
    end

    get '/collections' do
        logged_in
            @user = User.all
            erb :"collections/index"
    end

end