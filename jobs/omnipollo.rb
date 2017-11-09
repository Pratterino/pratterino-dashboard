require 'open-uri'
require 'nokogiri'

def get_omnipollo_beercam_url
  html = open('http://www.omnipolloshatt.com/')
  doc = Nokogiri::HTML(html)

  doc.xpath("//div[@class='front-block']").each {|div|
    img = div.xpath('./img/@src').to_s

    if img.include? 'beercam'
      return {
          :url => img,
          :updated => div.xpath('./p/text()').to_s
      }
    end
  }
end

SCHEDULER.every '10m', :first_in => 0 do
  omni = get_omnipollo_beercam_url
  unless omni.nil?
    send_event('omnipollo', {:url => omni[:url], :updated => omni[:updated]})
  end
end