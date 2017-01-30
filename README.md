# Redis High Availability on Kubernetes

... In one line:

```
$ sh create-redis.sh
```

This creates a 3-node redis cluster with sentinels.  What you get:

```
$ kubectl get po
NAME                   READY     STATUS    RESTARTS   AGE
redis-4kdwb            1/1       Running   0          10m
redis-ggb6b            1/1       Running   0          10m
redis-sentinel-9fd70   1/1       Running   0          10m
redis-sentinel-bmss5   1/1       Running   0          10m
redis-sentinel-qkb0t   1/1       Running   0          10m
redis-vn98d            1/1       Running   0          9m
```

To get redis info:

```
$ kubectl exec redis-4kdwb -- redis-cli info
```

Etc.

This script brought to you by the great example in the [kubernetes repo](https://github.com/kubernetes/kubernetes/tree/master/examples/storage/redis).  I just added delays during the redis HA bootstrap.
