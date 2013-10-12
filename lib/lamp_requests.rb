require_relative 'bridge_controller'

module LampRequests
  include BridgeController

# ON/OFF
  def turn_on
    update_lamp({'on' => true})
  end

  def turn_off
    update_lamp({'on' => false})
  end

# COLORLOOP
  def colorloop_on
    update_lamp({'effect' => 'colorloop'})
  end

  def colorloop_off
    update_lamp({'effect' => 'none'})
  end

# BRIGHTNESS
  def set_brightness(args = nil)
    command = { 'bri' => args.to_i }
    update_lamp(command)
  end

# COLOR
  def set_color(args)
    command = { 'hue' => args.to_i }
    update_lamp(command)
  end

  def set_saturation(args)
    command = {'sat' => args.to_i }
    update_lamp(command)
  end
end
