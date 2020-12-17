class GemstoneController < ApplicationController

    get '/gemstone/new' do
        logged_in
        erb :"gemstone/new"
    end

    post '/gemstone/new' do
        #binding.pry
        redirect_hacker
        gemstone = Gemstone.create(params[:gem])
        if gemstone.valid?
        redirect "/gemstones/#{params[:gem][:user_id]}"
        else
            flash[:incorrect] = "Form cannot be blank or you have reached the limit in one of the fields." 
            redirect "/gemstone/new"
        end
    end
    
    get '/gemstone/:id' do
        logged_in
        @gemstone = current_user.gemstones.find_by_id(params[:id])
        erb :"gemstone/show"
    end
    
    get '/gemstones/:id' do
        #binding.pry
            logged_in
            @gems =  current_user.gemstones  #Gemstone.where(user_id: params[:id])
            erb :"gemstone/index"
    end

    get '/gemstone/:id/edit' do
        #binding.pry
        logged_in
            @gem = Gemstone.find(params[:id])
            not_authorized
        erb :"gemstone/edit"
    end

    patch '/gemstone/:id' do
        @gem = Gemstone.find(params[:id])
        not_authorized
        @gem.update(params[:gem])
        redirect "gemstones/#{current_user.id}"
    end

    delete '/gemstone/:id/delete' do
        @gem = Gemstone.find(params[:id])
        not_authorized
        @gem.destroy
        redirect "/gemstones/#{current_user.id}"
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
        redirect "/user/#{session[:user_id]}"
        end
    end

end