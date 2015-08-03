class CommentsController < ApplicationController
  #must authenticate user before invoking any Comments method
  before_action :require_user 

  # post '/posts/:post_id/comments'
  def create 
    @post = Post.find(params[:post_id])
    @comment = Comment.new(params.require(:comment).permit(:body))
    @comment.post = @post #associate comment with the particular post
    @comment.creator = current_user #returns user object of logged in user
    
    if @comment.save
      flash[:notice] = "Your comment was added"
      redirect_to post_path(@post) #redirect must be a url
    else
      #comment was submitted from 'posts/show', so this is where
      #you go back to display errors. This template needs 
      #@post and @comment to be set up in order to work.
      render 'posts/show' # render must be a template file
    end
  end
  
end