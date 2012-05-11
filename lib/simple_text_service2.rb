require 'dcell'
require 'celluloid'
require 'socket'

ip = IPSocket.getaddress(Socket.gethostname)
# Join the cluster
DCell.start id: 'simple_text_node_2', addr: "tcp://#{ip}:13118", directory: { id: 'cluster_parent', addr: 'tcp://192.168.1.66:2042' }

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
