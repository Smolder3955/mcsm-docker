#!/bin/bash
set -eu
	if [ ! -d "/opt/mcsm/node_modules" ]; then
		echo "未找到面板，开始安装。"
		git clone https://gitee.com/Suwingser/MCSManager /opt/mcsm
		npm install --production
	fi

	if [ "$update" == "true"  ]; then
		echo "更新面板。"
		git pull
	else
		echo "跳过更新。"
	fi
echo "启动面板。"
node app.js
