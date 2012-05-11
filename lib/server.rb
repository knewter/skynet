# This will start a reel app and show all actor instances that it's aware of
# on the network.

# Based on DCell::Explorer
require 'dcell'
require 'reel'

require './lib/actor_lister'

# Web UI for DCell
# TODO: rewrite this entire thing with less hax
class Server < Reel::Server
  include Celluloid::IO
  def initialize(host = "127.0.0.1", port = 7779)
    @lister = ActorLister.new
    super(host, port, &method(:on_connection))
    STDOUT.puts "running on #{host}:#{port}"
  end

  def on_connection(connection)
    request = connection.request
    return unless request
    route connection, request
  end

  def route(connection, request)
    if request.url == "/"
      future = @lister.future :get_instances
      connection.respond :ok, future.value
    else
      connection.respond :not_found, "Not found"
    end
  end
end

if __FILE__ == $0
  s = Server.new
  sleep
end
