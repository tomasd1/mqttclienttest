require 'bunny'
require './test_message'
require 'protocol_buffers'

conn = Bunny.new
conn.start

# Device mqtt subscription:
# development/pb/g7_ah/devices/”device-id”/#
# development/pb/g7_ah/messages/#
# development/pb/g7_ah/owners/”owner-id”/#
#
# development/pb/g7_ah/devices/61/#
# development/pb/g7_ah/messages/#
# development/pb/g7_ah/owners/40/#

# key = 'mqtt-subscription-n878MCqKNHOMzWueFW12jAqos0'
key = 'mqtt.devices.62' # same key in subscriber in client.get(key)
channel = conn.create_channel

# exchange = channel.fanout("development.pb.g7_ah.messages", :durable => true) # all devices
# exchange = channel.topic("development.pb.g7_ah.devices.#{device_id}", :durable => true) # device
# exchange = channel.fanout("development.pb.g7_ah.owners.#{owner_id}"", :durable => true)
exchange = channel.topic('mqtt.topic', durable: true)

message = TestMessage.new(text: 'From web publisher to device subscriber', number: 1)

exchange.publish(message.to_s, routing_key: key)

conn.close
