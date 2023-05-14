# frozen_string_literal: true

require 'protocol_buffers'

# TestMessage
class TestMessage < ProtocolBuffers::Message
  required :string, :text, 1
  optional :int32, :number, 2
end
