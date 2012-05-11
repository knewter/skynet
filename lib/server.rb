# This will start a reel app and show all actor instances that it's aware of
# on the network.
require 'reel'
require 'dcell'

# Join the cluster
DCell.start directory: { id: 'cluster_parent', addr: 'tcp://127.0.0.1:2042' }

Reel::Server.supervise("0.0.0.0", 3000) do |connection|
  request = connection.request
  puts "Client requested: #{request.method} #{request.url}"
  puts get_instances.join(" ")
  connection.respond :ok, "hello, world"
end

def get_instances
  DCell::Node.all.map do |node|
    node.all
  end.flatten.uniq
end
