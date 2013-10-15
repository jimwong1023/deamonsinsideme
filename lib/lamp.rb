require_relative 'lamp_requests'
require 'net/http'
require 'multi_json'

class Lamp
  include LampRequests

  def initialize(ip, num, commands)
    @light_number = num
    @ip = ip
    message(commands)
  end

  def message(commands)
    commands.each { |msg, args| send_command(msg, args) }
  end

  def send_command(command, args = nil)
    args ? self.send(command, args) : self.send(command)
  end
end
