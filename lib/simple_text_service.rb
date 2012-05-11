require './lib/config'
require 'dcell'
require 'celluloid'
require 'socket'

# Join the cluster
DCell.start id: 'simple_text_node', addr: "tcp://#{IP}:13117", directory: { id: 'cluster_parent', addr: "tcp://#{CLUSTER_IP}:2042" }

class SimpleTextService
  include Celluloid

  def run
    "Some text!"
  end
end

if __FILE__ == $0
  SimpleTextService.supervise_as :simple_text_service
  sleep
end
