class UsersController < ApplicationController
  # call set_post before calling show, edit and update
  before_action :set_user, only: [:show, :edit, :update]
  before_action :require_same_user, only:[:edit, :update]

  def new
    @user = User.new 
  end

  def create 
    @user = User.new(user_params) #@user is populated with values from 'new' form
 
    if @user.save #@user.save returns "false" if can't save
      session[:user_id] = @user.id #now user will be logged in after he registers
      flash[:notice] = "You are registered as a user"
      #redirect must be a url
      redirect_to root_path #goes to index action    
    else  
      render :new #display new.html.erb
    end
  end

  def edit 
  end

  def show
  end

  def update # this is where the form displayed in 'edit' is submitted using verb "patch"
    if @user.update(user_params)
      flash[:notice] = "Profile is updated"
      # send to show user_path (add _path to the prefix)
      redirect_to user_path(@user)
    else
      render :edit
    end
  end
  
  private

  def user_params 
    params.require(:user).permit(:username, :password)
  end

  def set_user
    # ask ActiveRecord to find the user object in the db using the id from params
    #@user = User.find(params[:id]) #looking at the model layer
    @user = User.find_by(slug: params[:id])
  end

  def require_same_user
    if current_user != @user
      flash[:error] = "You cannot modify another user's information."
      redirect_to root_path
    end
  end

end

