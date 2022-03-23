require 'json'
require 'twitter'
require './generator'

credentials = JSON.parse(File.read("credentials.json"))

client = Twitter::REST::Client.new do |config|
    config.consumer_key = credentials['consumer_key']
    config.consumer_secret = credentials['consumer_secret']
    config.access_token = credentials['access_token']
    config.access_token_secret = credentials['access_token_secret']
end

if is_day()
  client.update('Yes')
  puts "Tweeted:\n#{text}"
end
