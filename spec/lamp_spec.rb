require_relative '../lib/lamp'
require 'rspec'

def lamp_data
  ["000.000.0.000",
    {"1"=>
      {"turn_off"=>nil,
        "colorloop_off"=>nil,
        "set_brightness"=>"154",
        "set_color"=>"51428",
        "set_saturation"=>"217"},
    "2"=>
      {"turn_off"=>nil,
        "colorloop_on"=>nil,
        "set_brightness"=>"0",
        "set_color"=>nil,
        "set_saturation"=>nil},
    "3"=>
      {"turn_off"=>nil,
        "colorloop_off"=>nil,
        "set_brightness"=>"0",
        "set_color"=>nil,
        "set_saturation"=>nil}}]
end

describe Lamp do
  Lamp.stub(:message){ "something" }

end
