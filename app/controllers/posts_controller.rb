class PostsController < ApplicationController
  #1.Use before_action to set up an instance variable for an action, 
  # in this case, call set_post before calling show, edit and update
  before_action :set_post, only: [:show, :edit, :update]

  #2.or to redirect based on some condition
  # call require_user for all Post methods except index and show
  # and unauthenicated user cannot create, edit or update a new post
  before_action :require_user, except: [:index, :show]

  # get '/'
  def index
    #Post.all accesses model layer and stores result in an instance variable
    #which is passed to the view
    @posts = Post.all  
    render 'posts/index' #happens by default and end of each method
  end

  # get '/posts/id'
  def show   # Here we display the form to be filled out
    #already have @post at this point
    #you need a comment object for the model backed form in 'posts/show'
    @comment = Comment.new # comment object 
    #render 'posts/show' (show.html.erb) automatically called before exiting this method
    #the form in 'posts/show' will submit info to path:
    #posts/id/comment which maps to comments#create
    #so a comments_controller is needed to create a comment via "def create"    
  end

  # get '/posts/new'
  def new
    #set up a new instance variable which is an active record object
    #and pass it to the 'new' template in "new.html.erb" 
    #which is called by default
    @post = Post.new 
  end

  # post '/posts'
  #the general pattern used in the action create that handles
  #submission of model-backed forms 
  def create 
    # the form displayed in "new.html.erb" is submitted to action='/posts' 
    # using verb method="post" which is routed to posts#create.
    # @post, is populated with values submitted from the form
    @post = Post.new(post_params)
    @post.creator = current_user #current_user: helper method in application_controller

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

  # get '/posts/id/edit'
  def edit #url will be something like /post/3/edit, edit form will be rendered
    #@post = Post.find(params[:id])
    #edit.html rendered by default
  end

  # patch '/posts/id'
  #the general pattern used in the action create that handles
  #submission of model-backed forms 
  def update # this is where the form displayed in 'edit' is submitted using verb "patch"
    if @post.update(post_params)
      flash[:notice] = "The post was updated"
      # send to show post_path (add _path to the prefix)
      redirect_to post_path(@post)
    else
      render :edit
    end
  end

  private

  def post_params
    #use strong parameters to expose the fields we're interested in
    #require top level key be post and allow changes to title,url,description, category_ids
    params.require(:post).permit(:title, :url, :description, category_ids: [])
    #To permit all attributes params.require(:post).permit!
  end

  def set_post
    # ask ActiveRecord to find the post object in the db using the id from params
    @post = Post.find(params[:id]) #looking at the model layer
  end

end
