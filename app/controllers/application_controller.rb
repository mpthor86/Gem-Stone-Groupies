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

  helpers do
    def valid_user?
        if session.include?(:user_id) && session[:user_id] == current_user.id
          true
        else 
          false
        end
    end
    def current_user
        User.all.find(session[:user_id])
    end
end

end
