require_relative 'lamp'
require 'pry'
require 'net/http'
require 'multi_json'

module PiController
  def update
     data = get_server
     lamp_updater(data[0], data[1])
  end

  def get_server
    uri = "http://huemorme.herokuapp.com/api/#{@env['TOKEN']}"
    response = Net::HTTP.get(URI.parse(uri))
    MultiJson.load(response)
  end
    # response.status should be 200 if everything is okay

  def lamp_updater(ip, lights_commands)
    lights_commands.each do |uniq_number, command|
      lamp = Lamp.new(ip, uniq_number)
      command.each do |msg, args|
        lamp.send_command(msg, args)
      end
    end
  end
end
