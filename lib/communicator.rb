require 'net/http'
require 'multi_json'
require 'yaml'
require 'pry'

API_LOCATION = YAML::load_file(File.expand_path(File.join(__dir__, '..', 'config.yaml')))
ADDRESS = "http://huemorme.herokuapp.com/api/#{API_LOCATION['TOKEN']}"

module Communicator
  class << self
    def huemorme_data
      response = Net::HTTP.get(URI.parse(ADDRESS))
      MultiJson.load(response)
    end

    def lights_data
      huemorme_data[1]
    end

    def ip
      huemorme_data[0]
    end

    def update(command)
      binding.pry
      address.request_put(parsed_uri.path, MultiJson.dump(command))
    end

    def address
      Net::HTTP.new(parsed_uri.host)
    end

    def parsed_uri
      URI.parse("#{base_uri}/state")
    end

    def base_uri
      "http://#{self.ip}/api/Huemormesilly/lights/#{self.lights_data}"
    end

    def state
      MultiJson.load(Net::HTTP.get(URI.parse(base_uri)))['state']
    end
  end
end
