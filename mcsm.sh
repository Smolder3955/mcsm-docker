#!/bin/bash
if [ ! -f "/opt/mcsm/app.js" ]; then
    git clone https://gitee.com/Suwingser/MCSManager /opt/mcsm
    npm install --production
fi
node app.js