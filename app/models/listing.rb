class Listing < ApplicationRecord
  belongs_to :condition
  belongs_to :category
  belongs_to :user
end
