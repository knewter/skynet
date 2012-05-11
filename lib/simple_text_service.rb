require 'dcell'
require 'celluloid'

# Join the cluster
DCell.start id: 'simple_text_node', addr: "tcp://127.0.0.1:13117", directory: { id: 'cluster_parent', addr: 'tcp://127.0.0.1:2042' }

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
