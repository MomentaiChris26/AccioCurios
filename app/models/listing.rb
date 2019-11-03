class Listing < ApplicationRecord
  # validations for creating or editing listings
  validates :posted_date, :description, :condition_id, presence: true
  validates :title, uniqueness: true, length: { minimum: 2 }, presence: true
  validates :price, numericality: { only_float: true }, presence: true
  
  belongs_to :condition
  belongs_to :category
  belongs_to :user
  enum sold: { available: 0, sold: 1 }
  accepts_nested_attributes_for :category, reject_if: :all_blank, allow_destroy: true
  has_one_attached :picture, dependent: :destroy
  has_many :comments, dependent: :destroy
  validates_associated :comments




end
