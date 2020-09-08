class Garden < ApplicationRecord
  has_many :plants, dependent: :destroy

  validates :name, presence: true, uniqueness: true
  validates :banner_url, presence: true

  # add validation url syntax
  validates :banner_url, format: { with: URI.regexp }
  
end
