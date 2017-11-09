require 'rest-client'
require 'json'

def get_instagram_profile_media
  secret = YAML::load_file('secret/settings.yml')
  username = secret['instagram']['username']
  response = RestClient.get("https://www.instagram.com/#{username}/?__a=1")

  json = JSON.parse(response)
  result = json['user']['media']['nodes'].map do |media|
    "#{media}\n"
  end

  result.join("\n")
end

SCHEDULER.every '10m', :first_in => 0 do
  print(get_instagram_profile_media)
  send_event('sl', {:url => get_instagram_profile_media})
end