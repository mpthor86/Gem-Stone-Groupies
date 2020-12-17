class UserController < ApplicationController
    
    get '/user/:id' do
        #binding.pry
        logged_in
        not_authorized
        @user = User.find(params[:id])
        erb :"user/show"
    end

    get '/login' do
        erb :"user/login"
    end

    post '/login' do
        user = User.find_by_username(params[:user][:username])
        if user && user.authenticate(params[:user][:password])
            session[:user_id] = user.id
            redirect "/user/#{user.id}"
        else 
            redirect_login
        end
    end

    get '/signup' do
        erb :"user/new"
    end

    post '/new' do
        user = User.new(params[:new_user])
        if user.valid? == false
            flash[:error] = "Either your Username is taken or Password is blank."
            redirect '/signup'
        else
            user.save
            session[:user_id] = user.id
            redirect "/user/#{user.id}"
        end
    end

    post '/logout' do
        session.clear
        redirect '/'
    end

    

    private

    def not_authorized
        if session[:user_id] != params[:id].to_i
            flash[:not_allowed] = "You dont have access to that page."
            redirect "user/#{session[:user_id]}"
        end
    end

end

