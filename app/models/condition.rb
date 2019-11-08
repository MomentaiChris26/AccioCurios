class Condition < ApplicationRecord
  # Sets validations
  validates :status, :format => { with: /\A[a-zA-Z ]+\z/}, uniqueness: true, presence: true

  # Sets relationships in database
  has_many :listings
end
