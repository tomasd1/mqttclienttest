# frozen_string_literal: true

require 'sneakers'
require 'protocol_buffers'
require './test_message'

Sneakers.configure connection: Bunny.new
Sneakers.configure exchange_type: :topic

# run: sneakers work Subscriber --require web_subscriber.rb
class Subscriber
  include Sneakers::Worker
  from_queue(
    'routa',
    ack: true,
    durable: true,
    exchange: 'mqtt.topic',
    routing_key: 'development.web.#'
  )

  def work_with_params(msg, delivery_info, metadata)
    p '----------'
    res = TestMessage.parse(msg)
    p res
    p res.class
    ack!
  end
end
