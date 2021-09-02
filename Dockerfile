FROM buildpack-deps:buster

# 环境变量
ARG PUID=1000
ARG PGID=1000
ENV PUID=$PUID
ENV PGID=$PGID
ENV TZ=Asia/Shanghai
ENV JAVA_HOME=/opt/jdk8u302-b01
ENV PATH=${JAVA_HOME}/bin:$PATH
ENV update=true
ENV TERM=xterm

# 替换成阿里源
RUN echo " " > /etc/apt/sources.list ;
RUN echo "deb http://mirrors.aliyun.com/debian buster main" >> /etc/apt/sources.list ;
RUN echo "deb http://mirrors.aliyun.com/debian buster-updates main" >> /etc/apt/sources.list ;

# 设置语言
RUN apt update && apt -y install locales
RUN sed -i '/en_US.UTF-8/s/^# //g' /etc/locale.gen && \
    locale-gen
ENV LANG en_US.UTF-8  
ENV LANGUAGE en_US:en  
ENV LC_ALL en_US.UTF-8

# 安装su-exec
RUN  set -ex; \
     \
     curl -o /usr/local/bin/su-exec.c https://raw.githubusercontent.com/ncopa/su-exec/master/su-exec.c; \
     \
     fetch_deps='gcc libc-dev'; \
     apt-get install -y --no-install-recommends $fetch_deps; \
     gcc -Wall \
         /usr/local/bin/su-exec.c -o/usr/local/bin/su-exec; \
     chown root:root /usr/local/bin/su-exec; \
     chmod 0755 /usr/local/bin/su-exec; \
     rm /usr/local/bin/su-exec.c; \
     \
     apt-get purge -y --auto-remove $fetch_deps
# 清理     
RUN apt clean && \
    rm -rf \
	/tmp/* \
	/var/lib/apt/lists/* \
	/var/tmp/*

# 添加用户
RUN adduser --disabled-password --shell /bin/bash --disabled-login --gecos "" mcsm

# 安装node
RUN cd /opt \
	&& wget https://npm.taobao.org/mirrors/node/v12.16.1/node-v12.16.1-linux-x64.tar.gz \
	&& tar -zxf node-v12.16.1-linux-x64.tar.gz \
	&& rm -rf node-v12.16.1-linux-x64.tar.gz \
	&& ln -s /opt/node-v12.16.1-linux-x64/bin/node /usr/bin/node \
	&& ln -s /opt/node-v12.16.1-linux-x64/bin/npm /usr/bin/npm
     
# 安装JRE8
RUN cd /opt \
    && curl -LJO  https://github.com/alibaba/dragonwell8/releases/download/dragonwell-8.8.8_jdk8u302-ga/Alibaba_Dragonwell_8.8.8_x64_linux.tar.gz \
    && tar -xzf Alibaba_Dragonwell_8.8.8_x64_linux.tar.gz \
    && rm Alibaba_Dragonwell_8.8.8_x64_linux.tar.gz
    
# 添加脚本
WORKDIR /home/mcsm/mcsmanager
ADD user.sh init.sh /home/mcsm/
RUN chmod +x /home/mcsm/user.sh /home/mcsm/init.sh

# 端口
EXPOSE 23333 25565 25566

# 面板目录
VOLUME /home/mcsm/mcsmanager
ENTRYPOINT ["/home/mcsm/user.sh", "/home/mcsm/init.sh"]
