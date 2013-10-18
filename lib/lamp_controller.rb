require_relative 'pi_controller'
require_relative 'communicator'
require 'yaml'

class LampController
  include PiController

  def initialize
    @last_updated = Communicator::lamp_data
  end

  def run
    loop do
      find_app_data(Communicator::lamp_data)
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


  def find_app_data(Communicator::ip, Communicator::lights_data)
    #destroy all lamps first - clean out db
    lights_data.each do |uniq_number, commands|
      Lamp.new(ip, uniq_number, commands)
    end
  end

end
