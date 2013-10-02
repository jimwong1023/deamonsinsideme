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

  def on?
    state['on']
  end

# COLORLOOP
  def colorloop_on
    update_lamp({'effect' => 'colorloop'})
  end

  def colorloop_off
    update_lamp({'effect' => 'none'})
  end

  def colorloop?
    state['effect'] == 'colorloop' ? true : false
  end

# BRIGHTNESS
  def set_brightness(args)
    command = { 'bri' => args }
    update_lamp(command)
  end

  def state_brightness
    state['bri']
  end

# COLOR
  def set_color(args)
    command = { 'hue' => args }
    update_lamp(command)
  end
end
