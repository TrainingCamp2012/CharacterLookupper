#!/usr/bin/ruby
require "rubygems"
require "json"
require "net/https"
require "uri"

access_token = '252050.8cc8bc1.0ea30324289a4567b772eabfad5d49fb'
access_param = "access_token=#{access_token}"
query_tags = "chata_cup"
tags_param = "q=#{query_tags}"
# http://d.hatena.ne.jp/snaka72/20080817/1218970157
# ruby JSON parser の使い方メモ
url_for_count = "https://api.instagram.com/v1/tags/search"



uri = URI.parse(url_for_count)
https = Net::HTTP.new(uri.host,443)
https.use_ssl = true
https.start {
  response = https.get(uri.path + "?#{tags_param}&#{access_param}")
  json = JSON.parse(response.body)
  puts json["data"][0]["media_count"].to_i
}

