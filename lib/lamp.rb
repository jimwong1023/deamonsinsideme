require 'multi_json'
require 'net/http'
require_relative 'lamp_requests'

class Lamp
  include LampRequests

  def initialize(ip, num)
    @light_number = num
    @ip = ip
  end

  def send_command(command, args = nil)
    args ? self.send(command, args) : self.send(command)
  end
end
