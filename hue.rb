require 'daemons'
require_relative './lib/huemorme'

options = {
  :backtrace  => true,
  :ontop      => false,
  :log_output => false
}

Daemons.run_proc('hue.rb', options) do
  client = HuemorMe.new
  client.run
end
