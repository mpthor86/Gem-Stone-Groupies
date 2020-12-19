class CommentController < ApplicationController
    get '/gemstone/:id/comments' do
        logged_in
        gemstone = Gemstone.find_by(params[:id])
        @comments = gemstone.comments
        #binding.pry
        erb :"comments/index"
    end
    
    get '/new_comment' do
        #binding.pry
        logged_in
        erb :"comments/new"
    end

    post '/new_comment' do
        logged_in
        not_allowed
        user = params[:comment]
        Comment.create(collection_id: session[:collection_id].to_i, comment: user[:input], user_id: user[:user_id])
        redirect "/#{session[:collection_id]}/comments"
    end


private


    def not_allowed
        if session[:user_id] != params[:comment][:user_id].to_i
        flash[:not_allowed] = "Why would you do that?"
        redirect "/user/#{session[:user_id]}/home"
        end
    end

end