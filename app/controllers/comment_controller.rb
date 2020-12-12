class CommentController < ApplicationController
    get '/:id/comments' do
        logged_in
        delete_collection_id
        @comments = Comment.where(collection_id: params[:id].to_i)
        #binding.pry
        @comments.each do |com|
            @user = User.where(id: com.user_id)
        end
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

def delete_collection_id
    if session.include?(:collection_id)
        session.delete(:collection_id)
    end
end

    def not_allowed
        if session[:user_id] != params[:comment][:user_id].to_i
        flash[:not_allowed] = "Why would you do that?"
        redirect "/user/#{session[:user_id]}/home"
        end
    end

end