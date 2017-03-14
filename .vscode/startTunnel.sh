#!/bin/bash
# startTunnel.sh creates a SSH tunnel to the container.
#   startTunnel.sh <cluster> <clusterUser> <clusterSSLPort> <hostIp> <container port> <local port>

cluster=$1
clusterUser=$2
clusterSSLPort=$3
hostIp=$4
containerPort=$5
localPort=$6

echo $(date) Start SSH tunnel ...

# kill any pre-existing tunnels. This is neeced before VSCode can support postLaunch command.
pkill -f "ssh -o StrictHostKeyChecking=no -L $localPort:"

nohup ssh -o StrictHostKeyChecking=no -L $localPort:$hostIp:$containerPort -f -t -N $clusterUser@$cluster -p $clusterSSLPort > /tmp/tunnel.std.out 2> /tmp/tunnel.err.out < /dev/null &

# wwait for the SSH channel to establish
sleep 1

cat /tmp/tunnel.err.out
