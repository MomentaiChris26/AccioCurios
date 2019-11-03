class Condition < ApplicationRecord
  validates :status, presence: true
  has_many :listings
end
