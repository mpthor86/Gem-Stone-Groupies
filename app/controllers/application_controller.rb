require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "Gems4lyfe"
    register Sinatra::Flash
  end

  get "/" do
    erb :home
  end

  not_found do
    status 404
    if session[:user_id]
      redirect "user/#{session[:user_id]}"
    else
    redirect '/'
    end
  end

  helpers do
    def logged_in
     if  !valid_user?
     redirect_login
      end
    end
    def valid_user?
         session.include?(:user_id) && session[:user_id] == current_user.id
    end
    
    def current_user
        User.find_by_id(session[:user_id])
    end

    def redirect_login
      flash[:uh_oh] = "You must be logged in."
      redirect '/login'
    end
end

end
