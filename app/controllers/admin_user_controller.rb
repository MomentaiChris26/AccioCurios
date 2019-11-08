class AdminUserController < ApplicationController
  authorize_resource :class => false # Cancancan authorisation to block non-admin from accessing admin functionalities
  before_action :set_user, only: [:edit, :update, :show, :destroy]
  
  def index
    
  end

 def edit
  authorize! :read, :admin_user # Cancancan authorisation that prevents non-admin from accessing the edit function in the admin controller
 end

 def update
  # Deletes the password if the password is blank
  params[:user].delete(:password) if params[:user][:password].blank?
  params[:user].delete(:password_confirmation) if params[:user][:password].blank? and params[:user][:password_confirmation].blank?
  
  
  if @user.update(user_params) # update method for notifying admin whether user has been successfully updated or not
    flash[:alert] = "Successfully updated User."
    redirect_to admin_path
  else
    render :action => 'edit'
  end

 end

  def destroy
    if @user.destroy # Provides a method that allows the admin to destroy the user
      flash[:alert] = "Successfully deleted User."
      redirect_to admin_path
    end
  end


  private
  def set_user # Sets the user id for editing or deleting purposes
    @user = User.find(params[:id])
  end
    
  def user_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation, :admin)
  end

end
