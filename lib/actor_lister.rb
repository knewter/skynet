# Join the cluster
# List the actors available
require 'celluloid'
require 'dcell'

# Join the cluster
DCell.start directory: { id: 'cluster_parent', addr: 'tcp://127.0.0.1:2042' }

class ActorLister
  include Celluloid

  def get_instances
    DCell::Node.all.map do |node|
      node.all
    end.flatten.uniq
  end
end
