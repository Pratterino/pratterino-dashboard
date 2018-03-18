require 'rest-client'
require 'json'
require 'nokogiri'

def get_news_items
  response = RestClient.get 'https://www.svt.se/nyheter/lokalt/stockholm/rss.xml'
  result = []
  xml = Nokogiri::XML(response)

  xml.xpath('//item').each {|item|
    result << {
        :title => item.xpath('./title/text()'),
        :desc => item.xpath('./description/text()'),
        :date => item.xpath('./pubDate/text()')
    }
  }
  result
end

SCHEDULER.every '10m', :first_in => 0 do
  news = get_news_items
  send_event('nyheter', {:nyheter => news, length: news.size})
end