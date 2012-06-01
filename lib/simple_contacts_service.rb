require './lib/config'
require 'dcell'
require 'celluloid'

# Join the cluster
DCell.start id: 'simple_contacts_service', addr: "tcp://#{IP}:13129", directory: { id: 'cluster_parent', addr: "tcp://#{CLUSTER_IP}:2042" }

class SimpleContactsService
  include Celluloid

  def run
    # Export an array of contacts
    [
      { name: "Josh Adams" },
      { name: "Tony Arcieri" },
      { name: "Bram Swenson" },
    ]
  end
end

if __FILE__ == $0
  SimpleContactsService.supervise_as :simple_contacts_service
  sleep
end
