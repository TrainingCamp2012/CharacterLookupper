#!/usr/bin/ruby
require "rubygems"
require "json/pure"
require "net/https"
require "uri"
require "functions"
# functions.rb

# http://d.hatena.ne.jp/snaka72/20080817/1218970157
# ruby JSON parser の使い方メモ

query_tags = "chata_cup"
access_token = '252050.8cc8bc1.0ea30324289a4567b772eabfad5d49fb'
base_url = "https://api.instagram.com/v1/tags/#{query_tags}/media/recent"
p count_tags("chata_cup")


 tags_param = "q=#{query_tags}"
 token_param = "access_token=#{access_token}"
 
 uri = URI.parse(base_url)
 https = Net::HTTP.new(uri.host,443)
 https.use_ssl = true
 https.start {
   response = https.get(uri.path + "?#{token_param}")
   json = JSON.parse(response.body)
 
 	json.size.times{|i|
 		p json["data"][i]["images"]["standard_resolution"]["url"]
 	}
 	next_session = json["pagination"]["next_url"]
 	response = https.get(next_session)
 	json = JSON.parse(response.body)
 
 	save_file(json["data"][0]["images"]["standard_resolution"]["url"])
 	p next_session = json["pagination"]#["next_url"]
 	#response = https.get(next_session)
 	#json = JSON.parse(response.body)
 }
 
 
 
