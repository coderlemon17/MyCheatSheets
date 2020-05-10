## 1. Redis配置

### 1.1. 拉取Redis镜像

### 1.2. 拉取Redis配置文件

-  wget https://raw.githubusercontent.com/antirez/redis/5.0/redis.conf -O redis.conf

    - 如果raw-github connection refused,　参见

        [DNS污染]: https://www.cnblogs.com/sinferwu/p/12726833.html

- 修改部分配置

    - ```
        # 允许外网访问redis
        bind 0.0.0.0  
        # 设置为守护进程
        daemonize no 
        # 允许外网访问redis
        protected-mode no 
        # 设置访问redis的密码
        requirepass Passwd17
        ```

- **Redis启动后直接挂掉**：

    - 检查配置文件是否设置了daemonize yes，如果是，就要改为daemonize no，因为该选项让redis成为在后台运行的守护进程，而**docker容器必须要有一个前台进程才能留存**。

    - 查看容器日志：

    - ```shell
      docker logs [OPTIONS] CONTAINER
          Options:
          --details        显示更多的信息
          -f, --follow         跟踪实时日志
          --since string   显示自某个timestamp之后的日志，或相对时间，如42m（即42分钟）
          --tail string    从日志末尾显示多少行日志， 默认是all
          -t, --timestamps     显示时间戳
          --until string   显示自某个timestamp之前的日志，或相对时间，如42m（即42分钟）
          
      e.g.
      docker logs -f -t --since="2018-02-08" --tail=100 CONTAINER_ID
      ```
      
    - 如果是`Permission denied`:

        - 在`docker run`中加入`--privileged=true`:
            - 此时容器中的`root`拥有真的`root`权限

    - 要使得docker无需root权限:

        - https://blog.csdn.net/liangllhahaha/article/details/92077065

        - ```
            sudo groupadd docker #添加docker用户组
            sudo gpasswd -a XXX docker #检测当前用户是否已经在docker用户组中，其中XXX为用户名，例如我的，liangll
            sudo gpasswd -a $USER docker #将当前用户添加至docker用户组
            newgrp docker #更新docker用户组
            
            
            //之后可以用docker version测试是否成功
            ```

-  save和bgsave

    -  save是同步保存，意思是redis在保存快照的时候会停止接收请求，bg则是后台模式
    -  如果不需要持久化则可以把这些都注释掉
    -  https://www.cnblogs.com/codingmode/p/12633261.html

- 配置内存限制和回收策略：

    - ```
        https://www.cnblogs.com/l1pe1/p/7873725.html
        # 限定最多使用1.5GB内存 
        maxmemory 1536mb
        # 设置策略为清理最少使用的key对应的数据 
        maxmemory-policy allkeys-lru 
        #配对的配置： 
        #默认值3，上面LRU和最小TTL策略并非严谨的策略，而是大约估算的方式，因此可以选择取样值以便检查 
        maxmemory-samples 3 
        ```

        

### 1.3. 启动Redis服务

```
docker run -p 6379:6379 --name myredis -v {DIR}/redis.conf:/etc/redis/redis.conf \
	-v {DIR}/data:/data \ 
    -itd redis \
    redis-server /etc/redis/redis.conf \
    --appendonly yes \\如果需要AOF
```

- -v {DIR}/data:/data：把redis持久化的数据在宿主机内显示，做数据备份
    - 可以用$PWD/data,使用当前路径下的data文件夹
- redis-server /etc/redis/redis.conf：这个是关键配置，让redis不是无配置启动，而是按照这个redis.conf的配置启动（后面的路径是容器内路径）
- Redis的持久化策略：
    - https://blog.csdn.net/q649381130/article/details/79920277
    - 全部保存在内存中（无持久化）
        - 内存设置（最大内存+清理
            - https://www.cnblogs.com/l1pe1/p/7873725.html
        - 关闭RDB
            - save ""
            - https://blog.csdn.net/qq_33999844/article/details/82625896
        - 关闭AOF（默认关闭）
    - RDB(默认开启)
        - RDB定时备份内存中的数据集。服务器启动的时候，可以从 RDB 文件中恢复数据集。
    - AOF
        - AOF记录服务器的所有写操作。在服务器重新启动的时候，会把所有的写操作重新执行一遍，从而实现数据备份。当写操作集过大（比原有的数据集还大），Redis 会重写写操作集。
    - 二者都开启

### 1.4. Redis的常用操作方式

- **Redis STRING使用**

    - https://www.cnblogs.com/passzhang/p/12237775.html

- Redis还可以存储**list , hash **等

- 显示有所键值：

    -  `keys *`

- 连接redis：

    - ```
        docker exec -ti myredis redis-cli -h localhost -p 6379
        auth Passwd17 //输入密码
```
        
        

### 1.4. Koa2中的Redis

- `npm install ioredis -S`

    - [ioredis]: https://github.com/luin/ioredis

    - config中的db:0

        - 默认情况下，redis会生成0-15号共16个db，以供不同情境使用的需要
        - 不同的数据库下，相同的key各自独立
        - https://www.jianshu.com/p/03c1276941cc

### TODO: Redis好文

- https://blog.csdn.net/striveb/article/details/85275266
- https://zhuanlan.zhihu.com/p/37055648