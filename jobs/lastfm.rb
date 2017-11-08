require 'open-uri'
require 'xmlsimple'
require 'yaml'

secret = YAML::load_file('secret/settings.yml')

username = secret['lastfm']['username']
api_key = secret['lastfm']['api-key']

SCHEDULER.every '1m', :first_in => 0 do |job|
  http = Net::HTTP.new('ws.audioscrobbler.com')
  response = http.request(Net::HTTP::Get.new("/2.0/?method=user.getrecenttracks&user=#{username}&api_key=#{api_key}"))
  response_status = XmlSimple.xml_in(response.body, {'ForceArray' => false})

  if response_status['status'] == "failed"

    failed = response_status['error']['content']

    send_event('lastfm', {:status => failed})

  else
    user_id = XmlSimple.xml_in(response.body, {'ForceArray' => false})['recenttracks']
    song = XmlSimple.xml_in(response.body, {'ForceArray' => false})['recenttracks']['track'][0]

    song['nowplaying'] == "true" ? track_status = "Now Playing" : track_status = "Last Played"

    song['image'][2]['content'].nil? ? image = "assets/no-album-art.jpg" : image = song['image'][2]['content']

    send_event('lastfm', {:status => 'ok', :cover => image, :artist => song['artist']['content'], :track => song['name'], :title => track_status})

  end

end