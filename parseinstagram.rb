#!/usr/bin/ruby
require "rubygems"
require "json"
require "net/https"
require "uri"

# http://d.hatena.ne.jp/snaka72/20080817/1218970157
# ruby JSON parser の使い方メモ
require 'uri'
require 'net/https'
require 'json'

url = 'https://api.instagram.com/v1/users/3/media/recent/'
access_token = YOUR_ACCESS_TOKEN
param = "access_token=#{access_token}"

uri = URI.parse(url)
https = Net::HTTP.new(uri.host,443)
https.use_ssl = true
https.start {
  response = https.get(uri.path + "?#{param}")
  json = JSON.parse(response.body)
  print json
}
