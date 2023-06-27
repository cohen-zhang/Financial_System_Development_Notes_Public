    daemonize yes
    pidfile /home/zz/redis/7000/redis.pid
    port 7000
    tcp-backlog 65535
    
	###绑定IP，默认0.0.0.0###
    bind 192.168.100.1
    requirepass zz123!
	masterauth "zz123!"
    timeout 0
    tcp-keepalive 0
    loglevel notice
    logfile /home/zz/redis/7000/log/redis.log
    databases 16
    lua-time-limit 5000
    maxclients 10000
    #protected-mode yes
    dir /home/zz/redis/7000/data
    
    ###cluster####
    
    cluster-enabled no
    cluster-config-file nodes-7000.conf
    cluster-node-timeout 15000
    
    ###慢日志参数###
    slowlog-log-slower-than 10000
    slowlog-max-len 128
    
    ###内存参数###
    maxmemory 8G
    maxmemory-policy volatile-lru
    
    ###RDB持久化参数###
    save 3600 1
    stop-writes-on-bgsave-error no
    rdbcompression yes
    rdbchecksum yes
    dbfilename dump.rdb
    
    ###AOF持久化参数###
    no-appendfsync-on-rewrite yes
    appendonly yes
    appendfilename "appendonly.aof"
    appendfsync no
    auto-aof-rewrite-min-size 512mb
    auto-aof-rewrite-percentage 100
    aof-load-truncated yes
    aof-rewrite-incremental-fsync yes
    
    ###客户端Buffer参数###
    client-output-buffer-limit normal 0 0 0
    client-output-buffer-limit slave 256mb 64mb 60
    client-output-buffer-limit pubsub 32mb 8mb 60
    
    ###其他参数###
    hash-max-ziplist-entries 512
    hash-max-ziplist-value 64
    list-max-ziplist-entries 512
    list-max-ziplist-value 64
    set-max-intset-entries 512
    zset-max-ziplist-entries 128
    zset-max-ziplist-value 64
    hll-sparse-max-bytes 3000
    activerehashing yes
    latency-monitor-threshold 0
    hz 10
