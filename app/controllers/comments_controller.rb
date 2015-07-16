class CommentsController < ApplicationController

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build(params.require(:comment).permit(:body))
    #@comment = Comment.new(params.require(:comment).permit(:body))

    if @comment.save
      flash[:notice] = "Your comment was added"
      redirect_to post_path(@post) #redirect must be a url
    else
      render 'post/show' # render must be a template file
    end
  end
  
end