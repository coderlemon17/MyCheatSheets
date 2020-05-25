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

## 镜像重命名

- https://blog.csdn.net/cs_sword2000/article/details/98453495
- docker images 找到image_id
- 用docker tag <image_id> 重新命名(注意它虽然叫tag但是其实并不是tag,就是重命名)
- 然后将原来的image删除

# Container（容器）

### 创建容器

- ```
  docker [container] create [NAME[:TAG]]
  ```

  - `-i`:  打开标准输入
  
  - `-d`: 在后台运行
  
  - `-t`:  分配一个伪终端
  
  - `-v [HOST-DIR:CONTAINER-DIR]`: 挂载主机上的文件卷到容器内
  
  - `-p hostPort:containerPort` : 指定如何映射到本地主机端口，e.g. `-p 11234-12234:1234:2234`
  
      - 如果一个参数的选项格式是[],比如
          -H=[]host
          -p=[]portdirection
          这都意味着这个flag可以多次出现，所以此处可以多次指定端口映射规则。
  
          例：docker run -d -p 80:80 -p 22:22
  
  - `--link=[<name or id>:alias]`: 链接到其他容器(可以使用`alias`表示被链接的容器)
  
  - `--rm=true|false`: 容器退出后是否自动删除（不能与`-d`共用）
  
- `--name=""`：容器的别名

- ```
  docker start [options] container [container...]
  or
  docker run [OPTIONS] IMAGE [COMMAND] [ARG...]
  ```

  - `run = create + start`
  - `docker run -it ubuntu:18.04 /bin/bash`: 启动一个终端并可以交互
- start:
      - `--attach, -a` 连接容器 
      -  `--interactive, -i` 连接容器终端
  - 容器自动退出:
      - https://blog.csdn.net/fengqing5578/article/details/94554897
  - 为了防止容器总是自动退出:
      - 创建时即选用-itd和/bin/bash
          - `docker run -idt --name="torcs" ubuntu:18.04 /bin/bash`:这样容器中就始终有一个`bash`在运行.
          - 接入是选取`exec`而非`attach`,否则`attach`的那个就是原来的终端,当你退出时容器也就退出了
          - 接入`exec`时不要选取`-d`
  
  ```
  docker container wait CONTAINER
  ```
  
  - 等待容器退出并打印结果
  
- ```
  docker ps //查看正在运行的容器
  docker ps -a //查看所有的容器
  ```

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
  - **想执行多条命令**:
      - docker exec ubuntu bash -c "cd hh && cd jj"

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

### 文件拷贝

- 都是在宿主机内操作:
    - 从容器拷贝到宿主机:
        -  **docker cp 容器名：要拷贝的文件在容器里面的路径    要拷贝到宿主机的相应路径**
    - 从宿主机拷贝到容器:
        - **docker cp 要拷贝的文件路径 容器名：要拷贝到容器里面对应的路径**
- e.g.:`docker cp /etc/apt/sources.list torcs:/etc/apt`

### 修改容器的端口映射:(!容器可能会丢失)

- https://blog.csdn.net/u010046887/article/details/90406271
    - 注意要先sudo su之后再操作,不然连cd和ls都没有权限,也没法自动提示
    - 要先停止容器和Docker的服务,不然修改完了还是会变回去
    - ...尝试失败,重启之后容器**不见了**

### ssh登录容器:

- 创建容器:

    - ```
    docker run -idt -p 10001:22 -v /home/lemon/Workspace/Playground/Docker/Pytorch:/docker_mnt --name="pytorch" myubuntu bash -c "service ssh start && /bin/bash"
        ```
        
        
    
- 个人设置:

    - ```
        // passwd root
        root: Passwd17
        
        //主机端口10001 -> 容器端口 22
        ```
        
- //最开始ssh是禁止root登录的,修改方法:
    
    - https://www.cnblogs.com/sunzebo/articles/9609457.html
        - 修改的是**sshd_config**而不是**ssh_config**
            - PermitRootLogin: yes
            - PasswordAuthentication: yes
    
- 创建新用户:
    
    - `sudo adduser lemon`
    
- https://blog.csdn.net/weixin_41845533/article/details/88803471

- 安装ssh:

    - sudo apt install openssh-server

- 启动服务:

    - service ssh start

- 创建用户:

    - `sudo adduser lemon`

    - [给用户添加sudo权限]: https://blog.csdn.net/lemonzone2010/article/details/5998502

    - **ssh 登录的是lemon, 容器自动登录的是root**

- 使用方式

    - `docker start torcs `
        - 不要加`-i`, 因为一旦加了, 你就相当于进入了容器启动时自带的那个bash, 这样你再退出, 那么唯一的那个前台bash也就退出了
        - 容器只有启动起来才能看到端口映射
        - 查看挂载目录:
            - `docker inspect container_name | grep Mounts -A 20`
    - `docker exec torcs service ssh start`
    - 然后`ssh -p 10001 lemon@localhot`, 密码Passwd17即可工作

### 初始化操作:

```
apt install build-essential openssh-server vim zsh
```

- zsh设置:

    - `chsh -s $(which zsh)`

    - zsh和on-my-zsh是两个东西:

        - 安装on-my-zsh:

        - ```
            sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
            ```

    - 对于oh-my-zsh的plugin:

        - 要么直接在plugin里写:

        - 要么先:

            - ```
                git clone git://github.com/zsh-users/zsh-autosuggestions $ZSH_CUSTOM/plugins/zsh-autosuggestions
                ```

            - 然后再在~/.zshrc的plugin里写

- **没有sudo就安装!**
    
    - apt install sudo
    
- Anaconda安装