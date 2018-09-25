require 'droplet_kit'
class Droplets
  include Enumerable

  def self.all
    @droplets = begin 
      client = DropletKit::Client.new(access_token: ENV.fetch('DIGITAL_OCEAN_API_TOKEN'))
      client.droplets.all.to_a
    end
  end

  def initialize(project, name)
    @project = project
    @name = name
  end

  def each
    self.class.all.each do |instance|
      next unless instance.name == instance_name
      network = instance.networks.v4.find { |network| network.type == 'public' }
      next unless network
      yield network.ip_address
    end
  end

  private

  def instance_name
    @instance_name ||= [@project, @name].join('.')
  end
end
