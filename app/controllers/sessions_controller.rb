class SessionsController < ApplicationController

  def new #display login form in new.html.erb
  end

  def create #after hitting submit in new form we go here
    # since sessions is non-model backed form, 
    # no errors are generated, must manually validate user information
    # get user obj
    user = User.find_by(username: params[:username])

    if user && user.authenticate(params[:password])
      #session is browser cookie
      #save user_id not object due to size limit of session
      session[:user_id] = user.id  
      flash[:notice] = "Login Successful"    
      redirect_to root_path #goes to index action 
    else   
      flash[:error] = "There's a problem with your username or password"
      redirect_to login_path 
    end 
  end

  def destroy 
    #remove user_id from session cookie
    session[:user_id] = nil
    flash[:notice] = "Logged Out"
    redirect_to root_path
  end

  private

  def user_params 
    params.require(:user).permit(:username, :password)
  end

end