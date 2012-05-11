# Join the cluster
# List the actors available
require 'celluloid'
require 'dcell'

# Join the cluster
DCell.start directory: { id: 'cluster_parent', addr: 'tcp://192.168.1.66:2042' }

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
