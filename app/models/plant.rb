class Plant < ApplicationRecord
  belongs_to :garden

  validates :name, presence: true, uniqueness: { scope: :garden_id }
  validates :image_url, presence: true

  # add validation url syntax
  validates :image_url, format: { with: URI.regexp }
  
end
