class CategoriesController < ApplicationController
  authorize_resource :class => false
  before_action :set_category, only: [:edit, :update, :show, :destroy] 

  def create
    @category = Category.create(category_params)
    if @category.errors.any?
      render 'category'
    else
      flash[:alert] = "Successfully Added New Category."
      redirect_to admin_path
    end
  end

  def destroy
    @category.destroy
    flash[:alert] = "Category Sucessfully Deleted"
    redirect_to admin_path
  end


  private

  def set_category
    @category = Category.find(params[:id])
  end

  def category_params
    params.require(:category).permit(:name)
  end

end
