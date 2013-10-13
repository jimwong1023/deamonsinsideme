require_relative 'pi_controller'
require 'yaml'

class LampController
  include PiController

  def initialize
    @env = YAML::load_file(File.expand_path(File.join(__dir__, '..', 'config.yaml')))
    @uri = "http://huemorme.herokuapp.com/api/#{@env['TOKEN']}"
    @last_updated = lamp_data
    @lamp_ip = ''
  end

  def run
    loop do
      find_app_data
      find_sleep
    end
  end
end
