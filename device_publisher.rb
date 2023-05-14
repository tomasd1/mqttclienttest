# frozen_string_literal: true

require 'mqtt'
require 'protocol_buffers'
require './test_message'

server = 'localhost'
device_id = 67
topic = "development/web/#{device_id}"
# topic = 'development/web/nic/5/test'

message = TestMessage.new(text: 'From device publisher to web subscriber', number: 2)

MQTT::Client.connect(server) do |c|
  2.times do
    c.publish(topic, message.to_s)
    p topic
    p 'sent'
    sleep 2
  end
end
