require 'open-uri'
require 'nokogiri'

def get_omnipollo_beercam_url
  html = open('http://www.omnipolloshatt.com/')
  doc = Nokogiri::HTML(html)

  img = doc.xpath("//div[@class='front-block'][1]/img").select {|img| img['src'].include? 'beercam'}
  img.first['src'].to_s
end

SCHEDULER.every '10m', :first_in => 0 do
  print(get_omnipollo_beercam_url)
  send_event('omnipollo', {:url => get_omnipollo_beercam_url})
end