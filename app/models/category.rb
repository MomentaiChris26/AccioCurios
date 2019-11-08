class Category < ApplicationRecord
  validates :name, :format => { with: /\A[a-zA-Z ]+\z/}, uniqueness: true, presence: true
  has_many :listings
end
