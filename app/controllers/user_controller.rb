class UserController < ApplicationController
    
    get '/user/:id/home' do
        #binding.pry
        if valid_user?
        @user = User.find(params[:id])
        erb :"user/user_home"
        else
            flash[:uh_oh] = "You must be logged in."
            redirect '/login'
        end
    end

    get '/login' do
        erb :"user/login"
    end

    post '/login' do
        user = User.find_by_username(params[:user][:username])
        if 
            user && user.authenticate(params[:user][:password])
            session[:user_id] = user.id
            redirect "/user/#{user.id}/home"
        else
            flash[:error] = "Incorrect Username or Password"
            redirect '/login'
        end
    end

    get '/new' do
        erb :"user/new"
    end

    post '/new' do
        user = User.new(params[:new_user])
        if user.valid? == false
            flash[:error] = "Either your Username is taken or Password is blank."
            redirect '/new'
        else
            user.save
            session[:user_id] = user.id
            redirect "/user/#{user.id}/home"
        end
    end

    post '/logout' do
        session.clear
        redirect '/'
    end

    get '/user/:id/collection' do
        #binding.pry
        if valid_user? == true
            @gems = Gemstone.where(user_id: params[:id])
            erb :"user/collection"
        else flash[:uh_oh] = "You must be logged in."
            redirect '/login'
        end
    end

end

