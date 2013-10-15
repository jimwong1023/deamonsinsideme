require_relative '../lib/pi_controller'
require 'rspec'
require 'webmock'
include WebMock::API


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

stub_request(:get, "http://huemorme.herokuapp.com/api/b642b4217b34b1e8d3bd915fc65c4452").
  with(:headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'Host'=>'huemorme.herokuapp.com', 'User-Agent'=>'Ruby'}).
  to_return(:status => 200, :body => lamp_data, :headers => {})


describe PiController do
  before(:each) do
    LampController.any_instance.stub(:env) { {'TOKEN' => 'b642b4217b34b1e8d3bd915fc65c4452',
                                            'IP' => '192.168.1.107'} }
    LampController.stub(:last_updated) { "hi" }
    LampController.any_instance.stub(:lamp_data) { lamp_data }
    LampController.any_instance.stub(:send_message) { "message sent" }
    @newController = LampController.new
  end

  context "#lamp_data" do
    it "should return ip and lights_commands" do
      expect(@newController.lamp_data[0]).to eq "000.000.0.000"
    end

    it "should return the lights_commands" do
      expect(@newController.lamp_data[1]["3"]).to eq({"turn_off"=>nil,
        "colorloop_off"=>nil,
        "set_brightness"=>"0",
        "set_color"=>nil,
        "set_saturation"=>nil})
    end
  end

  context "#find_sleep" do
    it "should sleep(10) if data is the same" do
      LampController.any_instance.stub(:last_updated) { lamp_data }
      @newController.find_sleep
    end
  end
end
