#!/usr/bin/ruby
def save_file(url)
  filename = File.basename(url)
  open(filename, 'wb') do |file|
    file.puts Net::HTTP.get_response(URI.parse(url)).body
  end
end
