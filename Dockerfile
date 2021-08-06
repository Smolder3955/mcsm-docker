FROM node:latest
#替换成阿里源
RUN echo " " > /etc/apt/sources.list ;
RUN echo "deb http://mirrors.aliyun.com/debian buster main" >> /etc/apt/sources.list ;
RUN echo "deb http://mirrors.aliyun.com/debian buster-updates main" >> /etc/apt/sources.list ;
#安装JDK8
RUN apt -y update && apt install -y software-properties-common
RUN wget -qO - https://adoptopenjdk.jfrog.io/adoptopenjdk/api/gpg/key/public | apt-key add - && add-apt-repository --yes https://mirrors.tuna.tsinghua.edu.cn/AdoptOpenJDK/deb/
RUN apt update && apt install -y adoptopenjdk-8-hotspot
#安装面板
RUN mkdir -p /opt/mcsm
COPY ./mcsm.sh /
RUN chmod +x /mcsm.sh
WORKDIR /opt/mcsm
ENTRYPOINT ["/mcsm.sh"]
VOLUME /opt/mcsm
