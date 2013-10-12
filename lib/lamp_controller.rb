require_relative 'pi_controller'
require 'yaml'

class LampController
  include PiController

  def initialize
    @env = YAML::load_file(File.expand_path(File.join(__dir__, '..', 'config.yaml')))
    @lamp_ip = ''
  end

  def run
    loop do
      update
      sleep(0.25)
    end
  end
end
