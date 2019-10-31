class AdminUserController < ApplicationController
  before_action :set_user, only: [:edit, :update, :show, :destroy]
  def index
    
  end

 def edit
  authorize! :read, :admin_user
 end

 def update
  # Deletes the password if the password is blank
  params[:user].delete(:password) if params[:user][:password].blank?
  params[:user].delete(:password_confirmation) if params[:user][:password].blank? and params[:user][:password_confirmation].blank?
  
  if @user.update(user_params)
    flash[:alert] = "Successfully updated User."
    redirect_to admin_path
  else
    render :action => 'edit'
  end

 end

  def destroy
    if @user.destroy
      flash[:alert] = "Successfully deleted User."
      redirect_to admin_path
    end
  end


  private
  def set_user
    @user = User.find(params[:id])
  end
    
  def user_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation, :admin)
  end

end
