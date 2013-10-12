require_relative 'lamp'
require 'pry'
require 'net/http'
require 'multi_json'

module PiController
  def update
     bridge_updater(lamp_data[0], lamp_data[1])
  end

  def lamp_data
    uri = "http://huemorme.herokuapp.com/api/#{@env['TOKEN']}"
    response = Net::HTTP.get(URI.parse(uri))
    MultiJson.load(response)
  end

  def bridge_updater(ip, lights_commands)
    lights_commands.each do |uniq_number, command|
      lamp = Lamp.new(ip, uniq_number)
      command.each do |msg, args|
        lamp.send_command(msg, args)
      end
    end
  end

  def find_sleep

    sleep(1)
  end
end
