FROM node:12-buster
#环境变量
ENV TZ=Asia/Shanghai
ENV JAVA_HOME=/opt/jdk8u292-b01
ENV PATH=${JAVA_HOME}/bin:$PATH
ENV update=true
#安装JDK8
RUN cd /opt \
    && wget https://github.com/alibaba/dragonwell8/releases/download/dragonwell-8.7.7_jdk8u292-ga/Alibaba_Dragonwell_8.7.7_x64_linux.tar.gz \
    && tar -xzf Alibaba_Dragonwell_8.7.7_x64_linux.tar.gz \
    && rm Alibaba_Dragonwell_8.7.7_x64_linux.tar.gz
#添加脚本
RUN mkdir -p /opt/mcsm
WORKDIR /opt/mcsm
ADD mcsm.sh /opt
RUN chmod +x /opt/mcsm.sh
#端口
EXPOSE 23333 25565 25566
#面板目录
VOLUME /opt/mcsm
ENTRYPOINT ["/opt/mcsm.sh"]
