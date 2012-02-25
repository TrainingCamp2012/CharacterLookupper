#!/usr/bin/ruby
require "rubygems"
require "net/https"
require "uri"

# http://www.5dollarwhitebox.org/drupal/node/64
class Net::HTTP
  alias_method :old_initialize, :initialize
  def initialize(*args)
    old_initialize(*args)
    @ssl_context = OpenSSL::SSL::SSLContext.new
    @ssl_context.verify_mode = OpenSSL::SSL::VERIFY_NONE
  end
end


class Instagram
 # todo  
 #
end

def count_tags(tag)
	access_token = '252050.8cc8bc1.0ea30324289a4567b772eabfad5d49fb'
	access_param = "access_token=#{access_token}"
	query_tags = tag
	tags_param = "q=#{query_tags}"
	url_for_count = "https://api.instagram.com/v1/tags/search"


	uri = URI.parse(url_for_count)
	https = Net::HTTP.new(uri.host,443)
	https.use_ssl = true
	https.start {
		response = https.get(uri.path + "?#{tags_param}&#{access_param}")
		json = JSON.parse(response.body)
		@count = json["data"][0]["media_count"].to_i
	}

	return @count
end

def save_file(url)
  filename = File.basename(url)
  open(filename, 'wb') do |file|
    file.puts Net::HTTP.get_response(URI.parse(url)).body
  end
end
