require_relative 'lamp'
require 'pry'

module LampRun
  def run
     data = get_server
     commands = data[1]
     lamp_updater(commands)
  end

  def get_server
    uri = "http://localhost:3000/api/#{@env['EMAIL']}"
    MultiJson.load(Net::HTTP.get(URI.parse(uri)))
  end

  def lamp_updater(lights_commands)
    lights_commands.each do |light_number, command|
      lamp = Lamp.new(@env['IP'], light_number, command[0], command[1])
      lamp.send_command
    end
  end
end
