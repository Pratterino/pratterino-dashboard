require 'rest-client'
require 'json'

def get_hagerstensasen_departures
  secret = YAML::load_file('secret/settings.yml')
  api_key = secret['sl']['api-key']
  site_id = secret['sl']['site-id']
  url = "http://api.sl.se/api2/realtimedeparturesv4.json?key=#{api_key}&siteid=#{site_id}&timewindow=30"
  response = RestClient.get(url)

  json = JSON.parse(response)
  result = json['ResponseData']['Metros'].map do |departure|
    "<li>#{departure['Destination']}, #{departure['DisplayTime']}\n</li>"
  end
  result.join("\n")
end

SCHEDULER.every '10m', :first_in => 0 do |job|
  print(get_hagerstensasen_departures)
  send_event('sl', {:url => get_hagerstensasen_departures})
end