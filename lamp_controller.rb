require_relative 'picontrols'
require 'yaml'

class LampController
  include LampRun

  def initialize(ip, email)
    @ip_address = ip
    @email = email
    write_yaml
  end


  def run
    loop do
      lamp_updater({"2" =>  ["turn_on"], "3" => ["turn_off"]})
      sleep(5)
      lamp_updater({"2" =>  ["turn_off"], "3" => ["turn_on"]})
      sleep(5)
    end
  end

  def write_yaml
    file = YAML::load_file('/Users/chae/01_DBC/DBC/huedaemon/pi.yaml')
    file['IP'] = @ip_address
    file['EMAIL'] = @email
    File.write('/Users/chae/01_DBC/DBC/huedaemon/pi.yaml', file.to_yaml)
  end
end
