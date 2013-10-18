ENV = YAML::load_file(File.expand_path(File.join(__dir__, '..', 'config.yaml')))
URI = "http://huemorme.herokuapp.com/api/#{ENV['TOKEN']}"

module Communicator


  def lamp_data
    response = Net::HTTP.get(URI.parse(URI))
    MultiJson.load(response)
  end

  def ip
    lamp_data[0]
  end

  def lights_data
    lamp_data[1]
  end

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
    "http://#{ip}/api/Huemormesilly/lights/#{lights_data}"
  end

  def state
    MultiJson.load(Net::HTTP.get(URI.parse(base_uri)))['state']
  end
end
