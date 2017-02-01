#!/usr/bin/env bash

# Create a bootstrap master
echo "$(date) - Creating redis master for bootstrapping..."
kubectl create -f templates/redis-master.yaml

# Create a service to track the sentinels
echo "$(date) - Creating redis sentinel service..."
kubectl create -f templates/redis-sentinel-service.yaml

echo "$(date) - Sleeping 60 seconds while redis-master bootstraps..."
sleep 30

# Create a replication controller for redis servers
echo "$(date) - Creating redis replication controller..."
kubectl create -f templates/redis-daemon-set.yaml

# Create a replication controller for redis sentinels
echo "$(date) - Creating redis sentinel replication controller..."
kubectl create -f templates/redis-sentinel-daemon-set.yaml

echo "$(date) - Sleeping 45 seconds while redis HA settles..."
sleep 45

# Delete the original master pod
echo "$(date) - Deleting bootstrap redis-master pod..."
kubectl delete pods redis-master

echo "$(date) - Waiting 30 seconds for replicas to see master is gone..."
sleep 30

echo "$(date) - Waiting 60 seconds for new leader to be elected..."
sleep 60

echo "$(date) - Done! ... But you might want to make sure everything is working :P"
