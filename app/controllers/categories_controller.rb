class CategoriesController < ApplicationController
  before_action :require_user, only: [:new, :create]

  def new
    @category = Category.new 
  end
 
  def create  
    @category = Category.new(category_params)

    if @category.save 
      flash[:notice] = "Your category was created"
      redirect_to root_path #goes to index action    
    else
      render :new #display new.html.erb
    end
  end

  def show 
    #binding.pry 
    @category = Category.find(params[:id])
  end

  private

  def category_params
    params.require(:category).permit(:name)    
  end

end
