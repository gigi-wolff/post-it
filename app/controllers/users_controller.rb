class UsersController < ApplicationController

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

  def update # this is where the form displayed in 'edit' is submitted using verb "patch"
    if @user.update(user_params)
      flash[:notice] = "Profile is updated"
      # send to show user_path (add _path to the prefix)
      redirect_to post_path(@user)
    else
      render :edit
    end
  end
  
  private

  def user_params 
    params.require(:user).permit(:username, :password)
  end
end

