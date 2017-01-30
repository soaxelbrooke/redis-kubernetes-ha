#!/usr/bin/env bash

# Create a bootstrap master
echo "$(date) - Creating redis master for bootstrapping..."
kubectl create -f templates/redis-master.yaml

echo "$(date) - Sleeping 60 seconds while redis-master bootstraps..."
sleep 60

# Create a service to track the sentinels
echo "$(date) - Creating redis sentinel service..."
kubectl create -f templates/redis-sentinel-service.yaml

# Create a replication controller for redis servers
echo "$(date) - Creating redis replication controller..."
kubectl create -f templates/redis-controller.yaml

# Create a replication controller for redis sentinels
echo "$(date) - Creating redis sentinel replication controller..."
kubectl create -f templates/redis-sentinel-controller.yaml

# Scale both replication controllers
echo "$(date) - Scaling replication controllers up from 0..."
kubectl scale rc redis --replicas=3
kubectl scale rc redis-sentinel --replicas=3

echo "$(date) - Sleeping 60 seconds while redis HA settles..."
sleep 60

# Delete the original master pod
echo "$(date) - Deleting bootstrap redis-master pod..."
kubectl delete pods redis-master

echo "$(date) - Waiting 30 seconds for replicas to see master is gone..."
sleep 30

echo "$(date) - Waiting 60 seconds for new leader to be elected..."
sleep 60

echo "$(date) - Done! ... But you might want to make sure everything is working :P"
