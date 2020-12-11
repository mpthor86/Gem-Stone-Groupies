class GemstoneController < ApplicationController

    get '/new_gem' do
        logged_in
        erb :"gemstone/new"
    end

    post '/new_gem' do
        #binding.pry
        redirect_hacker
        Gemstone.create(params[:gem])
        redirect "/user/#{params[:gem][:user_id]}/collection"
    end

    get '/gemstone/:id/edit' do
        #binding.pry
        logged_in
            @gem = Gemstone.find(params[:id])
            not_authorized
        erb :"gemstone/edit"
    end

    patch '/gemstone/:id/edit' do
        @gem = Gemstone.find(params[:id])
        not_authorized
        @gem.update(params[:gem])
        redirect "user/#{current_user.id}/collection"
    end

    delete '/gemstone/:id/delete' do
        @gem = Gemstone.find(params[:id])
        not_authorized
        @gem.destroy
        redirect "/user/#{current_user.id}/collection"
    end

    get '/users_collections' do
        logged_in
            @user = User.all
            erb :"users_collections/users_index"
    end

    get '/user/:id/view_collection' do
        logged_in
        @user = User.find(params[:id])
        @gems = Gemstone.where(user_id: params[:id])
        erb :"users_collections/collection_index"
    end

    private
    def not_authorized
        if session[:user_id] != @gem.user_id
            flash[:not_allowed] = "You dont have access to that page."
            redirect "/user/#{session[:user_id]}/home"
        end
    end

    def redirect_hacker
        if session[:user_id] != params[:gem][:user_id].to_i
        flash[:not_allowed] = "Cannot change others collections."
        redirect "/user/#{session[:user_id]}/home"
        end
    end

end