require_relative 'pi_controller'
require 'yaml'

class LampController
  include PiController

  def initialize
    @env = YAML::load_file(File.expand_path(File.join(__dir__, '..', 'config.yaml')))
    @lamp_ip = ''
    @time_last_updated = Time.now
  end

  def run
    loop do
      update
      find_sleep
    end
  end
end
