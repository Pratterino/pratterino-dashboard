require 'rest-client'
require 'json'

def get_crypto_prices
  response = RestClient.get("https://api.coinmarketcap.com/v1/ticker/?convert=SEK&limit=10")
  json = JSON.parse(response)

  json[0].each do |crypto|
    result = {
        :name => crypto['name'],
        :symbol => crypto['symbol'],
        :price => crypto['price_sek'],
        :change => crypto['percent_change_24h']
    }
    unless result.empty?
      return result
    end
  end
end

SCHEDULER.every '5m', :first_in => 0 do |job|
  send_event('crypto', {:crypto => get_crypto_prices})
end