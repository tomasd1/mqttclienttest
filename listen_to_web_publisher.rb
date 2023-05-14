# frozen_string_literal: true

# Archived for possible future testing purposes
# test worker originally intended to work with current Bikelink messaging setup

require 'sneakers'
require 'protocol_buffers'
require './user.rb'

Sneakers.configure :connection => Bunny.new
Sneakers.configure :exchange_type => :topic

# env.format.device_type.id.tx
# run: sneakers work Listener --require listen_to_web_publisher.rb
class Listener
  include Sneakers::Worker
  from_queue(
    'env.format.device_type.id.tx',
    ack: true,
    durable: true,
    exchange: 'mqtt.topic',
    routing_key: 'development.web.#'
  )

  def work_with_params(msg, delivery_info, metadata)
    p '----GOT MESSAGE FROM WEB------'
    res = User.parse(msg) #== msg # true
    p res
    p res.class
    ack!
  end
end
