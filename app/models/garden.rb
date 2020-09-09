class Garden < ApplicationRecord
  has_many :plants, dependent: :destroy

  validates :name, presence: true, uniqueness: true
  validates :banner_url, presence: true

  # add validation url syntax
  validates :banner_url, format: { with: URI.regexp }
  validates :banner_url, url: true
end


# verify url header contain image
# def image_exists?(url)
# 	url = URI.parse(url)
# 	http = Net::HTTP.new(url.host, url.port)
# 	http.use_ssl = (url.scheme = "https")
# 	req = Net::HTTP::Get.new(url.to_s)
# 	res = http.request(req)
# 	hash = res.each_header.to_h
# 	hash["content-type"].start_with? 'image'
# end