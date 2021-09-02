#!/bin/sh
exit_handler()
{
	echo "
            =======================================================================
            
            收到关闭信号！
            
            =======================================================================
        "

	# 关闭面板
        su-exec mcsm "$@"
        pikill npm

	echo "
            =======================================================================
            
            面板已关闭！
            
            =======================================================================
        "
	exit
}

# Trap specific signals and forward to the exit handler
trap 'exit_handler' SIGINT SIGTERM

set -eu

            # Print info
            echo "
            =======================================================================
            USER INFO:
            UID: $PUID
            GID: $PGID
            MORE INFO:
            If you have permission problems remember to use same user UID and GID.
            Check it with "id" command
            If problem persist check:
            https://github.com/vinanrra/Docker-7DaysToDie/blob/master/README.md
            =======================================================================
            "
# Set user and group ID to mcsm user
groupmod -o -g "$PGID" mcsm  > /dev/null 2>&1
usermod -o -u "$PUID" mcsm  > /dev/null 2>&1

# Apply owner to the folder to avoid errors
chown -R mcsm:mcsm /home/mcsm

# Change user to mcsm
su-exec mcsm "$@"
