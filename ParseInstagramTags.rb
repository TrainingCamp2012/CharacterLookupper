#!/usr/bin/ruby
require "rubygems"
require "json/pure"
require "net/https"
require "uri"
require "functions"
# functions.rb

# http://d.hatena.ne.jp/snaka72/20080817/1218970157
# ruby JSON parser の使い方メモ

query_tagname = "chata_cup"
access_token = '252050.8cc8bc1.0ea30324289a4567b772eabfad5d49fb'
base_url = "https://api.instagram.com/v1/tags/#{query_tagname}/media/recent"

counts = count_tags(query_tagname)

img_url_array = Array.new

tags_param = "q=#{query_tagname}"
token_param = "access_token=#{access_token}"

uri = URI.parse(base_url)
https = Net::HTTP.new(uri.host,443)
https.use_ssl = true
https.start {
  session_url = uri.path + "?#{token_param}"

  response = https.get(session_url)
  json = JSON.parse(response.body)

	json.size.times{|i|
		this_image = json["data"][i]
		img_url = this_image["images"]["standard_resolution"]["url"] # get 3 high res images
		img_url_array.push(img_url)
    created_time = Time.at(this_image["created_time"].to_i).strftime("%Y/%m/%d %H:%M:%S")
    user_name = this_image["user"]["username"]
		img_link = this_image["link"]
    img_likes = this_image["likes"]["count"]
		puts "#{user_name}" + " " + "#{created_time} #{img_link} #{img_likes}"
	}

	20.times{
		next_session_id = json["pagination"]["next_min_id"]
		next_session_url = "#{base_url}?#{token_param}&max_tag_id=#{next_session_id}" #438708459

		response = https.get(next_session_url)
		json = JSON.parse(response.body)
		this_image = json["data"][2]
		img_url = this_image["images"]["standard_resolution"]["url"] # get 3 high res images
		img_url_array.push(img_url)                  # push
		created_time = Time.at(this_image["created_time"].to_i).strftime("%Y/%m/%d %H:%M:%S")
		user_name = this_image["user"]["username"]
		img_link = this_image["link"]
		img_likes = this_image["likes"]["count"]
		puts "#{user_name}" + " " + "#{created_time} #{img_link} #{img_likes}"

	}
	#response = https.get(next_session)
	#json = JSON.parse(response.body)
}
p img_url_array
# save images
#
 img_url_array.size.times{|i|
 	save_file(img_url_array[i])
 }



