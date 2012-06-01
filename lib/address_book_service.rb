require './lib/config'
require 'dcell'
require 'celluloid'

# Join the cluster
DCell.start id: 'address_book_service', addr: "tcp://#{IP}:13139", directory: { id: 'cluster_parent', addr: "tcp://#{CLUSTER_IP}:2042" }

class AddressBookService
  include Celluloid

  def run
    contacts = DCell::Node[node][:simple_contacts_service].run
    output = ""
    output += "<ul>"
    contacts.each do |contact|
      output += "<li>#{contact[:name]}</li>"
    end
    output += "</ul>"
  end
end

if __FILE__ == $0
  AddressBookService.supervise_as :address_book_service
  sleep
end
