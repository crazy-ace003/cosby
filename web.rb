require_relative 'coins'
require 'sinatra'
require 'line/bot'

def client
  @client ||= Line::Bot::Client.new { |config|
    config.channel_secret = ENV["LINE_CHANNEL_SECRET"]
    config.channel_token = ENV["LINE_CHANNEL_TOKEN"]
  }
end

post '/callback' do
  body = request.body.read

  signature = request.env['HTTP_X_LINE_SIGNATURE']
  unless client.validate_signature(body, signature)
    error 400 do 'Bad Request' end
  end

  events = client.parse_events_from(body)
  events.each { |event|
    case event
    when Line::Bot::Event::Message
      case event.type
      when Line::Bot::Event::MessageType::Text
        msg = event.message['text']
        puts"#{msg}"
        if msg == "!eth"
          price_eth = Coins.priceEthereum()
          puts "#{price_eth}"
          message = {
            type: 'text',
            text: price_eth
          }
          client.reply_message(event['replyToken'], message)
        elsif msg == "!xmr"
          price_xmr = Coins.priceMonero()
          message = {
            type: 'text',
            text: price_xmr
          }
          client.reply_message(event['replyToken'], message)
        end
      end
    end
  }
  "OK"
end
