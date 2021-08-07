FROM adoptopenjdk:16-jre
#替换成阿里源
RUN echo "" > /etc/apt/sources.list
RUN echo "deb http://mirrors.aliyun.com/debian buster main" >> /etc/apt/sources.list
RUN echo "deb http://mirrors.aliyun.com/debian buster-updates main" >> /etc/apt/sources.list
RUN curl -sL https://deb.nodesource.com/setup_12.x | sudo -E bash -
RUN apt -y update
RUN apt-get install -y nodejs
#安装面板
RUN mkdir -p /opt/mcsm
COPY ./mcsm.sh /
RUN chmod +x /mcsm.sh
WORKDIR /opt/mcsm
ENTRYPOINT ["/mcsm.sh"]
VOLUME /opt/mcsm
