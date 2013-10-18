arequire_relative '../lib/lamp_controller'
require 'rspec'
require 'webmock' #look at VCR
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

describe LampController do
  context "initialization" do
    it "should run" do
      LampController.any_instance.stub(:env) { {'TOKEN' => 'b642b4217b34b1e8d3bd915fc65c4452',
                                              'IP' => '192.168.1.107'} }
      LampController.any_instance.stub(:lamp_data) { lamp_data }
      LampController.any_instance.stub(:find_app_data) { "finding app data" }
      LampController.any_instance.stub(:find_sleep) { "finding slee" }

      newController = LampController.new
      newController.should respond_to(:run).with(0).arguments
    end
  end
end
