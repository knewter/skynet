require './lib/config'
require 'dcell'
require 'celluloid'

# Join the cluster
DCell.start id: 'simple_text_node_2', addr: "tcp://#{IP}:13118", directory: { id: 'cluster_parent', addr: "tcp://#{CLUSTER_IP}:2042" }

class SimpleTextService2
  include Celluloid

  def run
    "Some ENTIRELY DIFFERENT text!"
  end
end

if __FILE__ == $0
  SimpleTextService2.supervise_as :simple_text_service2
  sleep
end
