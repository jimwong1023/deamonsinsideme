require_relative 'lamp'
require 'pry'
require 'net/http'
require 'multi_json'

module PiController
  def update
     data = get_server
     @lamp_ip = data[0]
     lamp_updater(@lamp_ip, data[1])
  end

  def get_server
    uri = "http://localhost:3000/api/#{@env['TOKEN']}"
    MultiJson.load(Net::HTTP.get(URI.parse(uri)))
  end

  def lamp_updater(ip, lights_commands)
    lights_commands.each do |uniq_number, command|
      lamp = Lamp.new(ip, uniq_number)
      command.each do |msg, args|
        lamp.send_command(msg, args)
      end
    end
  end
end
