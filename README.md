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
$ kubectl exec redis-4kdwb -- redis-cli info replication
# Replication
role:slave
master_host:$MYIP
master_port:6379
master_link_status:up
master_last_io_seconds_ago:0
master_sync_in_progress:0
slave_repl_offset:125585
slave_priority:100
slave_read_only:1
connected_slaves:0
master_repl_offset:0
repl_backlog_active:0
repl_backlog_size:1048576
repl_backlog_first_byte_offset:0
repl_backlog_histlen:0
```

Etc.

This script brought to you by the great example in the [kubernetes repo](https://github.com/kubernetes/kubernetes/tree/master/examples/storage/redis).  I just added delays during the redis HA bootstrap.
