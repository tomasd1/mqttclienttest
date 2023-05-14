# frozen_string_literal: true

require 'mqtt'
require './test_message'
require 'protocol_buffers'

client = MQTT::Client.new
client.host = '127.0.0.1'
client.client_id = 'g7_ahb_62'
topic = 'mqtt.devices.62'

Signal.trap('INT') do
  exit
end

client.connect do |c|
  c.subscribe(topic) # jako mqtt-subscription-n878MCqKNHOMzWueFW12jAqos0

  # If you pass a block to the get method, then it will loop
  c.get do |message_topic, message|
    puts "#{message_topic}: #{message}"
    puts "#{message_topic}: #{TestMessage.parse(message)}"
  end

ensure
  client.disconnect
end
