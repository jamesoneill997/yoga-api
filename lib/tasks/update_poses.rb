require 'net/http'
require 'json'

url = URI('https://www.pocketyoga.com/poses.json')
http = Net::HTTP.new(url.host, url.port)
http.use_ssl = true if url.scheme == 'https'

request = Net::HTTP::Get.new(url)

response = http.request(request)

if response.code == '200'
  poses = JSON.parse(response.body)
  poses.each do |pose|
    puts "Name: #{pose['name']}, URL: #{pose['url']}"
  end
  puts poses[0]
else
  puts "Error: #{response.code} - #{response.message}"
end