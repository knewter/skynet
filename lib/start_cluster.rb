require './lib/config'
require 'dcell'

DCell.setup id: 'cluster_parent', addr: "tcp://#{CLUSTER_IP}:2042"
DCell.run
