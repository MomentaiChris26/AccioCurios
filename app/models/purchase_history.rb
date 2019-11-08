class PurchaseHistory < ApplicationRecord
  # Sets relationships in database
  belongs_to :user
  belongs_to :listing
end
