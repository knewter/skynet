# Join the cluster
# List the actors available
require 'celluloid'
require 'dcell'

# Join the cluster
DCell.start directory: { id: 'cluster_parent', addr: 'tcp://127.0.0.1:2042' }

class ActorLister
  include Celluloid

  def get_instances
    instances = {}
    DCell::Node.all.each do |node|
      instances[node.id] = node.all
    end
    instances.inspect
  end
end
