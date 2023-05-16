# frozen_string_literal: true

require 'sneakers'

# Sneakers.configure connection: Bunny.new
# Sneakers.configure exchange_type: :topic

# sneakers work StandaloneSubscriber --require standalone_worker.rb
class StandaloneSubscriber
  include Sneakers::Worker
  from_queue(
    # 'routa',
    "#{Settings.bunny.environment}.web",
    connection: BunnyFactory.new.create,
    # ack: true,
    # durable: true,
    exchange: 'mqtt.topic',
    routing_key: 'development.web.#'
  )

  def work_with_params(msg, delivery_info, metadata)
    routing_key = reply_routing_key(delivery_info)
    reply_to_device(routing_key)
    ack!
  end

  private

  def reply_to_device(routing_key)
    message = 'ok'

    conn = Bunny.new
    conn.start
    channel = conn.create_channel
    exchange = channel.topic('mqtt.topic', durable: true)

    exchange.publish(message, routing_key: routing_key)
    p message
    p routing_key
    conn.close
  end

  def reply_routing_key(delivery_info)
    device_id = delivery_info[:routing_key].split('.')[-2]
    "development.pb.g7_ah.devices.#{device_id}.message"
  end
end
