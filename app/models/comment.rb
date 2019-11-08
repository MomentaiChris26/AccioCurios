class Comment < ApplicationRecord
  # Validations
  validates :body,:format => { with: /\A[a-zA-Z0-9 ].+\z/, :message => 'only letters and numbers or full stops' }, length: { minimum: 2 }, presence: true

  # Sets relationships in database
  belongs_to :user
  belongs_to :listing
end
