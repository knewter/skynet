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
    case request.url
    when "/"
      instances = @lister.get_instances
      text = render_actor_listing_html(instances)
      connection.respond :ok, text
    when /\/service\/(.*)\/(.*)/
      # Important note: Regex match backreferences, though they begin with a
      # dollar sign, are not traditional globals and are thus threadsafe
      node = $1
      service = $2
      html = html_page do
        text = "render a service guy - #{node} : #{service}<br />"
        begin
          text += DCell::Node[node][service.to_sym].run
        rescue
          text += "service failed, maybe not so much around?"
        end
      end
      connection.respond :ok, html
    else
      connection.respond :not_found, "Not found"
    end
  end

  def render_actor_listing_html(instances)
    html_page do
      html = ""
      html += "listing services"
      instances.each_pair do |node, services|
        if services.any?
          html += "<h2>Node: #{node}</h2>"
          html += "<ul>"
          services.each do |service|
            html += "<li>#{link_to_service(node, service)}</li>"
          end
          html += "</ul>"
        end
      end
      html
    end
  end

  def link_to_service(node, service)
    "<a href='/service/#{node}/#{service}'>#{service}</a>"
  end

  def html_page &block
    "<html><body>" + yield + "</html></body>"
  end
end

if __FILE__ == $0
  s = Server.new
  sleep
end
