require './lib/config'
require 'celluloid'
require 'dcell'

# Join the cluster
DCell.start id: 'actor_lister', addr: "tcp://#{IP}:13116", directory: { id: 'cluster_parent', addr: "tcp://#{CLUSTER_IP}:2042" }

class ActorLister
  include Celluloid

  # These are always running in a cluster
  DEFAULT_SERVICES = [:node_manager, :dcell_server, :info]

  def get_instances
    instances = {}
    DCell::Node.all.each do |node|
      instances[node.id] = node.all - DEFAULT_SERVICES
    end
    instances
  end
end
