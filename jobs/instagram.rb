require 'rest-client'
require 'json'

def get_instagram_profile_media
  secret = YAML::load_file('secret/settings.yml')
  username = secret['instagram']['username']
  response = RestClient.get("https://www.instagram.com/#{username}/?__a=1")

  json = JSON.parse(response)
  json['user']['media']['nodes'].each do |media, i|
    result = {
        :description => media['caption'] || '',
        :url => media['thumbnail_src'],
        :likes => media['likes']['count'],
        :comments => media['comments']['count']
    }
    unless result.empty?
      return result
    end
  end
end

SCHEDULER.every '15m', :first_in => 0 do
  send_event('instagram', {:instagram => get_instagram_profile_media})
end