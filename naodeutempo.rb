require "rubygems"
require "bundler/setup"

require 'nokogiri'
require 'open-uri'

url =  ARGV[0]
speak = ARGV[1]

while(true)
  puts "accessing page #{url}"
  puts 'Refreshing'
  offer = Nokogiri::HTML(open(url))

  status = offer.css('.boxBlue .priceTag div').text
  `say #{speak}` if(status != 'Oferta esgotada')

  sleep 10
end