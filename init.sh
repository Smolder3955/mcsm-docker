#!/bin/bash
set -eu

exit_handler()
{
	echo "收到关闭信号"
	pkill java
	sleep 30
	pkill npm
	sleep 30
	kill -SIGINT "$child"
	echo "面板已关闭"
	exit
}

# Trap specific signals and forward to the exit handler
trap 'exit_handler' SIGINT SIGTERM

if [ ! -f "$MCSM/app.js" ]; then
	echo "下载面板"
		git clone https://gitee.com/Suwingser/MCSManager $MCSM
	fi

	if [ ! -d "$MCSM/node_modules" ]; then
		echo "安装面板。"
		cd $MCSM
		npm install --production
	fi

	if [ "$UPDATE" == "true"  ]; then
		echo "更新面板。"
		cd $MCSM
		git pull
	else
		echo "跳过更新。"
	fi

cd $MCSM
echo "启动面板"

npm start &
child=$!
wait "$!"