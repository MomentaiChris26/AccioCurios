class ConditionsController < ApplicationController
  before_action :set_condition, only: [:edit, :update, :show, :destroy]
  def index
    @conditions = Condition.all
  end

  def create
    @condition = Condition.create(conditions_params)
    if @condition.errors.any?
      render 'condition'
    else
      redirect_to admin_path
    end
  end

  def destroy
    @condition.destroy
    redirect_to admin_path
  end

  private
  
  def set_condition
    @condition = Condition.find(params[:id])
  end

  def conditions_params
    params.require(:condition).permit(:status)
  end


end