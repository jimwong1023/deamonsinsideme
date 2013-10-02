module BridgeController
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
    "http://#{@ip}/api/1234567890/lights/#{@light_number}"
  end

  def state
    MultiJson.load(Net::HTTP.get(URI.parse(base_uri)))['state']
  end
end
