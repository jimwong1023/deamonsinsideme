require_relative 'picontrols'

class LampController
  include LampRun

  def initialize(ip, email)
    @ip_address = ip
    @email = email
  end

  def run
    loop do
      lamp_updater({"2" =>  ["turn_on"], "3" => ["turn_off"]})
      sleep(5)
      lamp_updater({"2" =>  ["turn_off"], "3" => ["turn_on"]})
      sleep(5)
    end
  end
end
