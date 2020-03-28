<center><font face="黑体" size="10">DOCKER 学习指南</font></center>

# Image（镜像）

## 管理镜像

- ```shell
  docker [image] pull NAME[:TAG]
  ```

  - e.g. :
    - `docker pull ubuntu:18.04`
    - `docker pull hub.c.163.com/public/ubuntu:18.04` : 指定仓库地址
  - `--registry-mirror=proxy_URL`：指定代理镜像地址，例如`https://registry.docker-cn.com`
  - 使用方式:https://www.cnblogs.com/wangjq19920210/p/9287545.html
  
- ```shell
  docker images
  or
  docker image ls
  ```

- ```shell
  docker tag ubuntu:latest myubuntu:latest
  ```

  - 只是加了一个标签

- ```
  docker [image] inspect ubuntu:18.04
  ```

  - `-f {{".Architecture"}}`:只会列出构架，例amd64

- ```
  docker history ubuntu:18:04
  ```

  - 会列出各层的创建信息
  - `--no-trunc`：可输出未截断的信息

- ```
  docker search [option] keyword
  ```

  - `-f, --filter`：过滤器：
    - e.g.: `--filter=star=4`：star超过4的镜像
    - e.g.: `--filter=is-official=true`：搜索官方镜像

- ```
  docker rmi IMAGE
  or
  docker image rm IMAGE
  ```

  - `-f, --force`: 即使有容器在使用它也删除
  - `--no-prone`:不清理没有标签的父镜像
  - **NOTE**:使用tag进行清理的时候，如果指向该容器的标签不止一个，则只删除标签；若只有一个则删除标签和镜像。（建议使用ID进行删除）

- ```
  docker image prune
  ```

  - `-a`：删除**所有**无用镜像，不光是临时
  - `-f`:强制删除

## 创建镜像

- ```
  docker [container] commit [OPTIONS] CONTAINRER [REPOSITORY[:TAG]] 
  ```

  - `-a, --author=""`：作者信息
  - `-m, --message=""`：提交信息
  - `-p, --pause=true`：提交时暂停容器运行
  - 可以用`ID`指明容器

- ```
  docker [image] import [OPTIONS] file|URL|- [REPOSITORY[:TAG]]
  ```

  - e.g.: `cat ubuntu-18.04.tar.gz | docker import - ubuntu:18:04`
    - 使用本地下载好的模板创建镜像

- ```
  docker [image] build -t python:3 DOCKERFILE
  ```

## 存出和载入镜像

- ```
  docker save -o ubuntu.tar ubuntu:18.04
  and
  docker load -i ubuntu.tar
  ```

## 上传镜像

- ```
  docker [image] push NAME[:TAG] | [REGISTRY_HOS[:REGISTRY_PORT]/]NAME[:TAG]
  ```

# Container（容器）

### 创建容器

- ```
  docker [container] create [NAME[:TAG]]
  ```

  - `-i`:  打开标准输入
  - `-d`: 在后台运行
  - `-t`:  分配一个伪终端
  - `-v [HOST-DIR:CONTAINER-DIR]`: 挂载主机上的文件卷到容器内
  - `-p`: 指定如何映射到本地主机端口，e.g. `-p 11234-12234:1234:2234`
  - `--link=[<name or id>:alias]`: 链接到其他容器(可以使用`alias`表示被链接的容器)
  - `--rm=true|false`: 容器退出后是否自动删除（不能与`-d`共用）
- `--name=""`：容器的别名
  
- ```
  docker start
  or
  docker run
  ```

  - `run = create + start`
  - `docker run -it ubuntu:18.04 /bin/bash`: 启动一个终端并可以交互

- ```
  docker container wait CONTAINER
  ```

  - 等待容器退出并打印结果

- ```
  docker ps
  ```

  - 查看正在运行的容器

- ```
  docker [container] logs
  ```

  - `-detail`:打印详细信息
  - `-f`:继续并保持下去
  - `-since string`:输出从某个时间开始的日志
  - `-until string`: 输出某个时间之前的日志
  - `-tail string`: 输出最近的若干日志

### 停止容器

- ```
  docker [container] pause CONTAINER [CONTAINER ……]
  and
  docker [container] unpause CONTAINER [CONTAINER ……]
  
  docker [container] stop [-t|--time[=10]] [CONTAINER ……]
  (在发送SIGTERM信号后等待10s之后再发送SIGKILL以终止容器)
  ```

  - 当容器中所指定的应用终结后，容器也会自动终止

- ```
  docker [container] restart CONTAINER
  ```

  - 会先将容器终止再启动

### 进入容器

- ```
  docker [containre] attach [--detach=keys[=[]]] [--no-stdin] [--sig-proxy[=true]]
  ```

  - `--detach-keys[=[]]`: 指定退出attach的快捷键，默认是`CTRL-p CTRL q`
  - `--no-stdin=true|false`: 是否关闭标准输入，默认标准输入关闭
  - `--sig-proxy=true|false`:是否代理收到的系统信号给应用进程，默认为true
  - **NOTE**:当多个窗口attach到一个容器之后，所有窗口都会同步显示，当一个窗口因为命令阻塞之后，其他窗口也就无法执行命令了。

- ```
  docker [container] exec [OPTIONS] CONTAINER COMMAND 
  ```

  - `-d`: 在后台执行
  - `-i`:打开标准输入接受用户命令，默认为false
  - `--privileged=true|false`：是否给命令以高权限，默认为false
  - `-t`：分配伪终端
  - `-u`：执行命令的用户名或ID
  - **NOTE**: `docker exec -it ubuntu /bin/bash`是最常用的命令

### 删除容器

- ```
  docker [container] rm
  ```

  - `-f`:强制删除
  - `-l`:删除容器的连接，但是保存容器
  - `-v`: :warning:**删除容器挂载的数据卷**

### 导入和导出容器

- ```
  docker [container] export [-o|--output[=""]] CONTAINER
  ```

  - 不管这个容器是否在运行中都可以保存

- ```
  docker import [-m [MESSAGE]] file|URL|- [REPOSITORY[:TAG]]
  ```

  - 导入的文件会生成**镜像**
  - e.g. `docker import test_for_fun.tar - ./ubuntu:18.04`