class Listing < ApplicationRecord
  # validations for creating or editing listings
  validates :posted_date, :description, presence: true
  validates :title, uniqueness: true, length: { minimum: 2 }, presence: true
  validates :price, numericality: { only_float: true }, presence: true
  validates_associated :comments
  
  belongs_to :condition
  belongs_to :category
  belongs_to :user

  has_one_attached :picture, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :purchase_histories, dependent: :destroy

  enum sold: { available: 0, sold: 1 }
  accepts_nested_attributes_for :category, reject_if: :all_blank, allow_destroy: true
  accepts_nested_attributes_for :condition, reject_if: :all_blank, allow_destroy: true

 

  
  

end
