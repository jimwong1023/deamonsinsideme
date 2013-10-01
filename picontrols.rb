# TODO (JW):
# 1. Create a new project (not rails) for this 'daemon'.
# 2. Google "how to write daemon ruby" for best practices.
# 3. Create a Gemfile for bundler for your daemon project.
# 4. Use good file organization as in phase 1 ... folders, etc.
# 5. Break any assumptions you made in your modules that you're
#    in a Rails app.



#!/usr/bin/env ruby
require_relative 'lamp'

def get_server(email)
  uri = "http://localhost:3000/api/#{email}"
  MultiJson.load(Net::HTTP.get(URI.parse(uri)))
end

def lampcreator(ip, username, lights_commands)
  lights_commands.each do |light_number, command|
    lamp = Lamp.new(ip, username, light_number, command[0], command[1])
    lamp.send_command
  end
end

loop do
  lampcreator("192.168.0.152", "1234567890", {"2" => ["toggle_on_off"], "3" =>  ["toggle_on_off"]})
  sleep(2)
end
