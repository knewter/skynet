require 'dcell'

DCell.start id: 'cluster_parent', addr: 'tcp://127.0.0.1:2042'

sleep # stay alive forever...
