require 'multi_json'
require 'net/http'
require_relative 'lamp_requests'

class Lamp
  include LampRequests

  def initialize(ip, username, light_number, command, args = nil)
    @ip = ip
    @username = username
    @light_number = light_number
    @command = command
    @args = args
  end
  
  def send_command
    @args ? self.send(@command, @args) : self.send(@command)
  end
end