require'colorize'
require 'uri'
require'json'
module Coins
  class << self
    public
    def priceMonero()
        uri = URI.parse("https://api.coinmarketcap.com/v1/ticker/monero/")
        response = Net::HTTP.get_response(uri)
        data = JSON.parse(response.body)
        price_usd = data[0]['price_usd'].to_s
        price_btc = data[0]['price_btc'].to_s
        precent_change1h = data[0]['percent_change_1h']
        precent_change24h = data[0]['percent_change_24h']
        #monero = "***          MONERO          ***```\n-Price USD: $ #{price_usd}\n" + "-Price BTC: ฿ #{price_btc}\n" + "-Price Change 1 hour: #{precent_change1h}\n" + "-Precent Chnage 24 hours: #{precent_change24h}```"
        monero = "**        MONERO          **\n-Price USD: $ #{price_usd}\n" + "-Price BTC: ฿ #{price_btc}\n" + "-Price Change 1 hour: #{precent_change1h}\n" + "-Precent Chnage 24 hours: #{precent_change24h}"
         monero
    end
    def priceBitcoin()
        uri = URI.parse("https://api.coinmarketcap.com/v1/ticker/bitcoin/")
        response = Net::HTTP.get_response(uri)
        data = JSON.parse(response.body)
        price_usd = data[0]['price_usd'].to_s
        price_btc = data[0]['price_btc'].to_s
        precent_change1h = data[0]['percent_change_1h']
        precent_change24h = data[0]['percent_change_24h']
        monero = "**BITCOIN**```\n-Price USD: $ #{price_usd}\n" + "-Price BTC: ฿ #{price_btc}\n" + "-Price Change 1 hour: #{precent_change1h}\n" + "-Precent Chnage 24 hours: #{precent_change24h}```"
    end
    def priceEthereum()
        uri = URI.parse("https://api.coinmarketcap.com/v1/ticker/ethereum/")
        response = Net::HTTP.get_response(uri)
        data = JSON.parse(response.body)
        price_usd = data[0]['price_usd'].to_s
        price_btc = data[0]['price_btc'].to_s
        precent_change1h = data[0]['percent_change_1h']
        precent_change24h = data[0]['percent_change_24h']
        monero = "***ETHEREUM***```\n-Price USD: $ #{price_usd}\n" + "-Price BTC: ฿ #{price_btc}\n" + "-Price Change 1 hour: #{precent_change1h}\n" + "-Precent Chnage 24 hours: #{precent_change24h}```"
    end
    def priceStellar()
        uri = URI.parse("https://api.coinmarketcap.com/v1/ticker/stellar/")
        response = Net::HTTP.get_response(uri)
        data = JSON.parse(response.body)
        price_usd = data[0]['price_usd'].to_s
        price_btc = data[0]['price_btc'].to_s
        precent_change1h = data[0]['percent_change_1h']
        precent_change24h = data[0]['percent_change_24h']
        monero = "***STELLAR***```\n-Price USD: $ #{price_usd}\n" + "-Price BTC: ฿ #{price_btc}\n" + "-Price Change 1 hour: #{precent_change1h}\n" + "-Precent Chnage 24 hours: #{precent_change24h}```"
    end
  end
end
