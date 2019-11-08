class CategoriesController < ApplicationController
  load_and_authorize_resource # Cancancan authorisation which only allows admin to access. 
  before_action :set_category, only: [:edit, :update, :show, :destroy] 

 
  def create # Provides method for creation of Categories
    @category = Category.create(category_params)
    if @category.errors.any?
      render 'category'
    else
      flash[:alert] = "Successfully Added New Category."
      redirect_to admin_path
    end
  end

  
  def destroy # Provides method for deletion of Categories
    @category.destroy
    flash[:alert] = "Category Sucessfully Deleted"
    redirect_to admin_path
  end


  private

  def set_category # Finds the category using the id parameters
    @category = Category.find(params[:id])
  end

  def category_params
    params.require(:category).permit(:name)
  end

end
