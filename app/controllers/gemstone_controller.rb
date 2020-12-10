class GemstoneController < ApplicationController
    get '/lsit_all' do 
        @gems = Gemstone.all
        @user = User.all
        erb :"gemstone/index"
    end

    get '/gemstone/new' do
        if valid_user? == true
        erb :"gemstone/new"
        else
            flash[:uh_oh] = "You must be logged in."
            redirect '/login'
        end
    end

    post '/gemstone/new' do
        #binding.pry
        gem = Gemstone.new(params[:gem])
        gem.save
        redirect "/user/#{params[:gem][:user_id]}/collection"
    end

    get '/gemstone/:id/edit' do
        if valid_user? == true
            @gem = Gemstone.find_by_id(params[:id])
        erb :"gemstone/edit"
        else flash[:uh_oh] = "You must be logged in."
            redirect '/login'
        end
    end

    patch '/gemstone/:id/edit' do
        gem = Gemstone.find_by_id(params[:id])
        gem.update(params[:gem])
        redirect "user/#{current_user.id}/collection"
    end

    delete '/gemstone/:id/delete' do
        gem = Gemstone.find_by_id(params[:id])
        gem.destroy
        redirect "/user/#{current_user.id}/collection"
    end

end