class Listing < ApplicationRecord
  belongs_to :condition
  belongs_to :category
  belongs_to :user
  enum sold: { available: 0, sold: 1 }
  accepts_nested_attributes_for :category, reject_if: :all_blank, allow_destroy: true
  has_one_attached :picture
  has_many :comments, dependent: :destroy
end
