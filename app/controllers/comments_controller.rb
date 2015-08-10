class CommentsController < ApplicationController
  #must authenticate user before invoking any Comments method
  before_action :require_user #have a current_user

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

    # POST /posts/:post_id/comments/:id/vote
    # needs 2 objects, post and comment
    def vote
    #create vote object
    comment = Comment.find(params[:id])
    vote = Vote.create(voteable: comment, creator: current_user, vote: params[:vote])

    if vote.valid?
      flash[:notice] = "Your vote was counted"
    else
      flash[:error] = "You can only vote for once for a particular item"
    end

    redirect_to :back #go back to whatever url you came from

  end

  
end