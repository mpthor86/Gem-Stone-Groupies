require './config/environment'

class UserController < ApplicationController
    #get '/user' do
    #    erb :user.erb
    #end

    get '/user/:id' do
        binding.pry
        @user = User.find_by(params[:id])
        erb :"user/index"
    end
    
    post '/user' do
        #binding.pry
        user = User.find_by_username(params[:user][:username])
        if 
            user && user.authenticate(params[:user][:password])
            session[:user_id] = user.id
            redirect "/user/#{user.id}"
        else
            redirect '/error'
        end
    end

    post '/user/new' do
        user = User.new(params[:new_user])
        if
            #binding.pry
            valid?(user) == false
            redirect '/error'
        else
            user.save
            redirect "/user/#{user.id}"
            
        end
    end

    get '/error' do
        erb :error
    end

    helpers do
        def valid?(user)
            if
                user.username.blank? || user.password.blank? || User.find_by_username(params[:new_user][:username])
                false
            else
                true
            end
        end
    end

end

#if
#    
#else
#    user.save
#    
#    
#end