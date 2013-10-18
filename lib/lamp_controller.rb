require_relative 'communicator'
require 'yaml'

class LampController

  def initialize
    @last_updated = Communicator::lamp_data
  end

  def run
    loop do
      update_bridge(Communicator::lamp_data)
      find_sleep
    end
  end

  ######################

  def find_sleep
    if @last_updated == Communicator::lamp_data
      sleep(10)
    else
      sleep(2)
      @last_updated = Communicator::lamp_data
    end
  end

  def update_bridge(lights_data)
    lights_data.each do |uniq_number, commands|
      Lamp.new(uniq_number, commands)
    end
  end
end


