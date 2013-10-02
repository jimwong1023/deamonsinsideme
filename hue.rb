require 'daemons'
require_relative './lib/lamp_controller'

options = {
  :backtrace  => true,
  :ontop      => false,
  :log_output => false
}

Daemons.run_proc('hue.rb', options) do
  lamp_controller = LampController.new
  lamp_controller.run
end
