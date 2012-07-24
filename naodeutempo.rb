require "rubygems"
require "bundler/setup"

require 'nokogiri'
require 'open-uri'

def windows?
  (/cygwin|mswin|mingw|bccwin|wince|emx/ =~ RUBY_PLATFORM) != nil
end

def mac?
 (/darwin/ =~ RUBY_PLATFORM) != nil
end

def unix?
  !windows?
end

def linux?
  unix? and not mac?
end


def say(text)
  puts text

  if mac?
    `say #{text}`
  elsif unix? and linux?
    `echo "#{text}"|espeak`
  else
    raise 'OS not supported'
  end
end


url =  ARGV[0]
speak = ARGV[1]

while(true)
  puts "accessing page #{url}"
  puts 'Refreshing'
  offer = Nokogiri::HTML(open(url))

  status = offer.css('.boxBlue .priceTag div').text

  if status != 'Oferta esgotada'
    say(speak)
  end

  sleep 10
end
