require 'dcell'
require 'celluloid'
require 'socket'

ip = IPSocket.getaddress(Socket.gethostname)
# Join the cluster
DCell.start id: 'simple_text_node', addr: "tcp://#{ip}:13117", directory: { id: 'cluster_parent', addr: 'tcp://192.168.1.66:2042' }

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
