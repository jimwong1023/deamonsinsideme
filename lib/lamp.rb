require_relative 'bridge_requests'
require 'net/http'
require 'multi_json'

class Lamp
  include BridgeRequests

  def initialize(uniq_num, commands)
    @light_number = uniq_num
    set_properties(commands)
  end

  def set_properties(commands)
    properties = {}
    commands.each do |msg, args|
      values = send_command(msg, args)
      properties = properties.merge!(values)
    end
    Communicator::update(properties)
  end

  def send_command(command, args = nil)
    args ? self.send(command, args) : self.send(command)
  end
end

Client - consturct lamps - but passses itself to lamp
