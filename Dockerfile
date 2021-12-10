FROM buildpack-deps:buster

# 环境变量
ENV LANG C.UTF-8
ENV TZ=Asia/Shanghai
ENV MCSM=/opt/mcsmanager
ENV JAVA_HOME=/opt/jdk-17.0.1.0.1+12
ENV NODE_HOME=/opt/node-v12.16.1-linux-x64
ENV PATH=${NODE_HOME}/bin:${JAVA_HOME}/bin:$PATH

# 替换成阿里源
RUN echo " " > /etc/apt/sources.list ;
RUN echo "deb http://mirrors.aliyun.com/debian buster main" >> /etc/apt/sources.list ;
RUN echo "deb http://mirrors.aliyun.com/debian buster-updates main" >> /etc/apt/sources.list ;

# 清理     
RUN apt clean && \
    rm -rf \
	/tmp/* \
	/var/lib/apt/lists/* \
	/var/tmp/*

# 安装node
RUN cd /opt \
	&& wget https://npm.taobao.org/mirrors/node/v12.16.1/node-v12.16.1-linux-x64.tar.gz \
	&& tar -zxf node-v12.16.1-linux-x64.tar.gz \
	&& rm -rf node-v12.16.1-linux-x64.tar.gz
     
# 安装JRE17
RUN cd /opt \
	&& curl -LJO https://dragonwell.oss-cn-shanghai.aliyuncs.com/17.0.1.0.1%2B12/Alibaba_Dragonwell_17.0.1.0.1%2B12_aarch64_linux.tar.gz \
	&& tar -xzf Alibaba_Dragonwell_17.0.1.0.1%2B12_aarch64_linux.tar.gz \
	&& rm Alibaba_Dragonwell_17.0.1.0.1%2B12_aarch64_linux.tar.gz
    
# 添加脚本
ADD init.sh /opt/
RUN chmod +x /opt/init.sh

# 启动
WORKDIR $MCSM
ENTRYPOINT ["/opt/init.sh"]

# 持久化
VOLUME $MCSM
# 开放端口
EXPOSE 23333 25565 25566
