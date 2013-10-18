module BridgeRequests

# ON/OFF
  def turn_on
    {'on' => true}
  end

  def turn_off
    {'on' => false}
  end

# COLORLOOP
  def colorloop_on
    {'effect' => 'colorloop'}
  end

  def colorloop_off
    {'effect' => 'none'}
  end

# BRIGHTNESS
  def set_brightness(args = nil)
    { 'bri' => args.to_i }
  end

# COLOR
  def set_color(args)
    { 'hue' => args.to_i }
  end

  def set_saturation(args)
    {'sat' => args.to_i }
  end
end
