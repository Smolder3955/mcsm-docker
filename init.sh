#!/bin/bash
set -eu
	if [ ! -f "/home/mcsm/mcsmanager/app.js" ]; then
		echo "未找到面板，开始安装。"
		git clone https://gitee.com/Suwingser/MCSManager ~/mcsmanager
		npm install --production
	fi
	
	if [ ! -d "/home/mcsm/mcsmanager/node_modules" ]; then
		echo "安装面板。"
		npm install --production
	fi

	if [ "$update" == "true"  ]; then
		echo "更新面板。"
		git pull
	else
		echo "跳过更新。"
	fi
	
echo "启动面板。"
npm start 
