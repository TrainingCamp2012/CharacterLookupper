#!/usr/bin/ruby
require "rubygems"
require "json"
require "net/https"
require "uri"
access_token = '252050.8cc8bc1.0ea30324289a4567b772eabfad5d49fb'
access_param = "access_token=#{access_token}"
query_user = "iNut" #187372
user_param = "q=#{query_user}"
url_for_count = "https://api.instagram.com/v1/users/search"



uri = URI.parse(url_for_count)
https = Net::HTTP.new(uri.host,443)
https.use_ssl = true
https.start {
  response = https.get(uri.path + "?#{user_param}&#{access_param}")
  json = JSON.parse(response.body)
  p json["data"]
}

