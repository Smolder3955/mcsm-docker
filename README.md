# [mcsm-docker](https://github.com/Suwings/MCSManager)

## 运行  
### 直接使用宿主网络  
`docker run --name=mcsm -it -d -v <host_ptah>:/home/mcsm/mcsmanager --net="host" efsg/mcsm-docker:jre8`  
### 端口映射  
默认Web端口为23333，可用`-p`映射容器的端口  
`docker run --name=mcsm -it -d -v <host_ptah>:/home/mcsm/mcsmanager -p 23333:23333 -p 25565:25565 -p 25566:25566 efsg/mcsm-docker:jre8`  
> 如果是高版本服务端，使用JRE16镜像 `efsg/mcsm-docker:jre16`
### 变量:

|参数|说明|
|-|:-|
| `PUID` |用户ID|
| `PGID` |用户组ID|
| `--name=mcsm` |容器名|
| `-p 23333:23333` |Web访问端口|
| `-net="host"` |直接使用宿主网络|
| `-v <宿主机目录>:/home/mcsm/mcsmanager` |面板文件|
| `update` |如果为`true`，启动时自动更新面板|
> 使用 `id <用户名>` 命令获取用于运行面板用户的UID和GID

## 构建  
```
git clone https://github.com/efsg/mcsm-docker.git
cd mcsm-docker
docker build docker build . -t mcsm_docker:latest
```

## Credit
脚本参考自 https://github.com/vinanrra/Docker-7DaysToDie
