class Plant < ApplicationRecord
  belongs_to :garden

  validates :name, presence: true, uniqueness: { scope: :garden_id }
  validates :image_url, presence: true

  # add validation url syntax
  validates :image_url, format: { with: URI.regexp }

	# verify if image url is correct
	def image_exists?(url)
		url = URI.parse(url)
		http = Net::HTTP.new(url.host, url.port)
		http.use_ssl = (url.scheme = "https")
		req = Net::HTTP::Get.new(url.to_s)
		res = http.request(req)
		hash = res.each_header.to_h
		hash["content-type"].start_with? 'image'
	end
end
