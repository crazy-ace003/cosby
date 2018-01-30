require 'sinatra'
require 'sinatra/logger'
require 'line/bot'
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
  events.each do |event|
    case event
    when Line::Bot::Event::Message
      case event.type
      when Line::Bot::Event::MessageType::Text
        say_message = event.message['text']
        if say_message == "!eth"
            priceEth = Coins.priceEthereum()
            message = {
              type: 'text',
              text: priceEth
            }
            response = client.reply_message(event['replyToken'], message)
        elsif say_message == "!xmr"
           pricrXmr = Coins.priceMonero()
           message = {
              type: 'text',
              text: priceXmr
            }
            response = client.reply_message(event['replyToken'], message)
        end
      when Line::Bot::Event::MessageType::Image, Line::Bot::Event::MessageType::Video
        response = client.get_message_content(event.message['id'])
        tf = Tempfile.open("content")
        tf.write(response.body)
      end
    end
  end

  "OK"
end
