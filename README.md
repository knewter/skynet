# Skynet
The goal of skynet is to build a self-replicating network of Actor objects using
Celluloid/DCell with properties such that it's hard to kill all the services
short of shutting down every machine in the network.

## Usage

- start the cluster on the machine that will act as the hub.
  - in the end goal, this hub is not required.
  - `ruby lib/start_cluster.rb`
- run the server on your local machine (each person playing should run their own
  local server)
  - `ruby lib/server.rb`
- make a new actor that joins the cluster
  - `ruby lib/simple_text_service.rb`
- ensure that your local sinatra app's index now reflects that actor
  - visit http://127.0.0.1:7779

## Prerequisites

- ruby knowledge
- zeromq - just grab it and build it/install it
