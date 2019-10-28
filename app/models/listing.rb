class Listing < ApplicationRecord
  belongs_to :condition
  belongs_to :category
  belongs_to :user
  enum sold: { available: 0, sold: 1 }
end
