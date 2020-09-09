class UrlValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
  	if value.match(URI.regexp)
    	record.errors[attribute] << (options[:message] || "must be an image URL") unless image_exists?(value)
    end 
  end
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

