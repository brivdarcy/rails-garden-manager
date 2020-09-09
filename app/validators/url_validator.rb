class UrlValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    record.errors[attribute] << (options[:message] || "must be a valid URL") unless image_exists?(value)    
  end

  # a URL may be technically well-formed but may 
  # not actually be valid, so this checks for both.
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