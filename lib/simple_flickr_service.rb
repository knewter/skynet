require './lib/config'
require 'dcell'
require 'celluloid'
require 'atom/feed'
require 'socket'

# Join the cluster
DCell.start id: 'simple_flickr_node', addr: "tcp://#{IP}:13333", directory: { id: 'cluster_parent', addr: "tcp://#{CLUSTER_IP}:2042" }

class SimpleFlickrService
  include Celluloid

  def run
    # Get some pics from flickr
    feed = Atom::Feed.new("http://api.flickr.com/services/feeds/photos_public.gne"+
                          "?tags=kitten&format=atom")
    feed.update!
    output = ''
    feed.entries.each do |entry|
      output += "<h2>#{entry.title}</h2>"
      output += "<h3>#{entry.authors.first.name}</h2>"
      output += "<img src='#{entry.links.last.href}' />"
    end
    output
  end
end

if __FILE__ == $0
  SimpleFlickrService.supervise_as :simple_flickr_service
  sleep
end
