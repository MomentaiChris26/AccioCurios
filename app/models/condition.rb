class Condition < ApplicationRecord
  validates :status, uniqueness: true, presence: true
  has_many :listings
end
