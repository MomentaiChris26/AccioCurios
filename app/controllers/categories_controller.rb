class CategoriesController < ApplicationController
  before_action :set_category, only: [:edit, :update, :show, :destroy] 


  def destroy
    @category.destroy
    flash[:alert] = "Category Sucessfully Deleted"
    redirect_to admin_path
  end


  private

  def set_category
    @category = Category.find(params[:id])
  end

end
