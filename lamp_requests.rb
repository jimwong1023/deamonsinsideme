module LampRequests

#Views
  # def say_colorloop
  #   colorloop? ? "off" : "on"
  # end

  # def say_on_off
  #   on? ? "off" : "on"
  # end

  # def say_brightness
  #   "#{state_brightness}"
  # end
# COLOR
  def set_color(args)
    command = { 'hue' => args }
    update_lamp(command)
  end

# BRIGHTNESS
  def set_brightness(args)
    command = { 'bri' => args }
    update_lamp(command)
  end

  def state_brightness
    state['bri']
  end

  # COLORLOOP
  def toggle_colorloop
    command = colorloop? ? {'effect' => 'none'} : {'effect' => 'colorloop'}
    update_lamp(command)
  end

  def colorloop?
    state['effect'] == 'colorloop' ? true : false
  end

  # ON/OFF
  def toggle_on_off
    command = on? ? {'on' => false} : {'on' => true}
    update_lamp(command)
  end

  def on?
    state['on']
  end


  #####################################
  # Methods for sending bridge commands
  def update_lamp(command)
    address.request_put(parsed_uri.path, MultiJson.dump(command))
  end

  def address
    Net::HTTP.new(parsed_uri.host)
  end

  def parsed_uri
    URI.parse("#{base_uri}/state")
  end

  def base_uri
    "http://#{@ip}/api/#{@username}/lights/#{@light_number}"
  end

  def state
    MultiJson.load(Net::HTTP.get(URI.parse(base_uri)))['state']
  end
end
