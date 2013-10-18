require 'net/http'
require 'multi_json'
require 'yaml'
require 'pry'

USER = YAML::load_file(File.expand_path(File.join(__dir__, '..', 'config.yaml')))
ADDRESS = "http://huemorme.herokuapp.com/api/#{USER['TOKEN']}"

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

    def update(lights, command)
      address.request_put(parsed_uri.path, MultiJson.dump(command))
    end

    def address
      Net::HTTP.new(parsed_uri.host)
    end

    def parsed_uri
      URI.parse("#{base_uri}/state")
    end

    def base_uri
      "http://#{self.ip}/api/Huemormesilly/lights/1"
    end

    def state
      MultiJson.load(Net::HTTP.get(URI.parse(base_uri)))['state']
    end
  end
end
