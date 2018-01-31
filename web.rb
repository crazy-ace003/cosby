require 'sinatra'   # gem 'sinatra'
require 'line/bot'  # gem 'line-bot-api'
require_relative 'coins'

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
        eth_price = Coins.priceEthereum()
        if event.message['text'] == "!eth"
          message = {
            type: 'text',
            text: eth_price
          }
          client.reply_message(event['replyToken'], message)
        elsif event.message['text'] == "!xmr"
          xmr_price = Coins.priceMonero()
          message = {
            type: 'text',
            text: xmr_price
          }
          client.reply_message(event['replyToken'], message)
      end
    end
  }

  "OK"
end
