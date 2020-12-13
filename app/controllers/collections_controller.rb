class CollectionsController < ApplicationController
    get '/user/:id/view_collection' do
        logged_in
        @user = User.find(params[:id])
        session[:collection_id] = @user.id
        @gems = Gemstone.where(user_id: params[:id])
        erb :"collections/collection_index"
    end

    get '/users_collections' do
        logged_in
            @user = User.all
            erb :"collections/users_index"
    end
end