class PostsController < ApplicationController
  #1.set up an instance variable for an action
  #2.redirect based on some condition
  before_action :set_post, only: [:show, :edit, :update]

  def index
    @posts = Post.all
    #happens by default (but a good reminder)
    #render must be a template file
    render 'posts/index' #happens by default, but a good reminder
  end

  def show  
    #already have @post at this point
    @comment = Comment.new #routes.rb contains "resources :comments, only: [:create]"
    #so you need a comments_controller to handle "def create"
    #render 'posts/show' will go to show.html.erb
  end

  def new
    @post = Post.new #won't hit db, only make a Post object in memory
    #will go to "new.html.erb"
  end

  def create 
    # set up a variable in memory (@post) that is populated
    # with values submitted from the form
    @post = Post.new(post_params)
    @post.creator = User.first #-----MUST BE FIXED IN FUTURE ------

    if @post.save #@post.save returns "false" if can't save
      flash[:notice] = "Your post was created"
      #redirect must be a url
      redirect_to posts_path #goes to index action    
    else
    #validation error occured. We must render to have access to 
    #"post.error.full_messages" array to display generated errors   
      render :new #display new.html.erb
    end
  end

  def edit #url will be /post/3/edit
  end

  def update
    if @post.update(post_params)
      flash[:notice] = "The post was updated"
      # send to show post_path
      redirect_to post_path(@post)
    else
      render :edit
    end
  end

  private

  def post_params
    #use strong parameters to expose the fields we're interested in
    #require post top level key be post
    params.require(:post).permit(:title, :url, :description)

    #Here we permit all attributes params.require(:post).permit!
  end

  def set_post
    # ask ActiveRecord to find the post object in the db using the id from params
    @post = Post.find(params[:id]) #looking at the model layer
  end

end
