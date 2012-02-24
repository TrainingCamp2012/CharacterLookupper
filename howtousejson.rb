#!/usr/bin/ruby
require "rubygems"
require "json/pure"
# http://d.hatena.ne.jp/snaka72/20080817/1218970157
# ruby JSON parser の使い方メモ

json = JSON.parser.new("{ \"key\" : \"value\" }")

p json.parse()


