require_relative 'lamp'
require 'pry'
require 'net/http'
require 'multi_json'

module PiController
  def find_app_data
     parse_app_data(lamp_data[0], lamp_data[1])
  end

  def lamp_data
    response = Net::HTTP.get(URI.parse(@uri))
    MultiJson.load(response)
  end

  def parse_app_data(ip, lights_commands)
    lights_commands.each do |uniq_number, command|
      lamp = Lamp.new(ip, uniq_number)
      command.each do |msg, args|
        lamp.send_command(msg, args)
      end
    end
  end

  def find_sleep
    if @last_updated == lamp_data
      sleep(10)
    else
      sleep(2)
      @last_updated = lamp_data
    end
  end
end
