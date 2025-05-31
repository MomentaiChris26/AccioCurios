class Listing < ApplicationRecord
  # Sets validations
  validates :posted_date, presence: true
  validates :description, :format => { with: /\A[a-zA-Z0-9 ].+\z/, :message => 'no special characters, only letters and numbers' }, presence: true
  validates :title, uniqueness: true, :format => { with: /\A[a-zA-Z0-9 ]+\z/ , :message => 'no special characters, only letters and numbers' }, length: { minimum: 2 }, presence: true
  validates :price, :format => { :with => /\A\d+(?:\.\d{0,2})?\z/, message: "must be numercial and only contain two decimal points" }, numericality: { less_than_or_equal_to: 999998, only_float: true }, presence: true
  validates_associated :comments
  
  # Sets relationships in database
  belongs_to :condition
  belongs_to :category
  belongs_to :user
  has_one_attached :picture, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :purchase_histories

  enum sold: { available: 0, sold: 1 }
  accepts_nested_attributes_for :category, reject_if: :all_blank, allow_destroy: true
  accepts_nested_attributes_for :condition, reject_if: :all_blank, allow_destroy: true

 

  
  

  def image_url # Or picture_url if you prefer to match the attachment name
    if picture.attached?
      # Ensure Rails.application.routes.url_helpers is available
      # and default_url_options are set for the environment (e.g., in development.rb)
      # Example: config.action_mailer.default_url_options = { host: 'localhost', port: 3000 }
      begin
        Rails.application.routes.url_helpers.rails_blob_url(picture, only_path: false) # false for full URL
      rescue ArgumentError => e # Catches if default_url_options host is missing
        Rails.logger.error "Failed to generate image URL for Listing #{id}: #{e.message}. Check default_url_options."
        nil # Or return a placeholder / path if full URL generation fails
      end
    end
  end
end
