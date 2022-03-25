require 'json'
require 'tweetkit'
require 'yalemenus'

credentials = JSON.parse(File.read("credentials.json"))

client = Tweetkit::Client.new do |config|
    config.consumer_key = credentials['consumer_key']
    config.consumer_secret = credentials['consumer_secret']
    #config.bearer_token = credentials['bearer_token']
    config.access_token = credentials['access_token']
    config.access_token_secret = credentials['access_token_secret']
end

def is_day
  YaleMenus.halls.each { |hall|
    YaleMenus.hall_meals(hall['id'], date: Date.today).each { |meal|
      YaleMenus.meal_items(meal['id']).each { |item|
        if item['name'].downcase().include? 'chicken tenders'
          return true
        end
      }
    }
  }
  return false
end

if is_day()
  p response = client.post_tweet(text: 'Yes')
  puts response
  puts "Tweeted!"
end
