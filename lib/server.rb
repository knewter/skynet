# This will start a sinatra app and show all actor instances that it's aware of
# on the network.
require 'sinatra'
require './lib/actor_lister'

lister = ActorLister.new

get '/' do
  lister.get_instances.join(" ")
end
