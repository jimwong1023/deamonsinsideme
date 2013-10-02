require_relative 'lamp'
require 'pry'

module LampRun
  def get_server
    uri = "http://localhost:3000/api/#{@email}"
    MultiJson.load(Net::HTTP.get(URI.parse(uri)))
  end

  def lamp_updater(lights_commands)
    lights_commands.each do |light_number, command|
      lamp = Lamp.new(@ip_address, light_number, command[0], command[1])
      lamp.send_command
    end
  end

  def run
     data = get_server
     commands = data[1]
     lamp_updater(commands)
  end
end
