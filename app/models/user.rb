class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :listings, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :purchase_histories, dependent: :destroy
  validates :username, :email, uniqueness: true

  # instead of deleting, indicate the user requested a delete & timestamp it  
  def soft_delete 
    update_attribute(:deleted_at, Time.current)
  end  
  
  # ensure user account is active  
  def active_for_authentication?  
    super && !deleted_at  
  end  
  
  # provide a custom message for a deleted account   
  def inactive_message   
    !deleted_at ? super : :deleted_account  
  end 
end
