#!/bin/bash

. /etc/ossec-init.conf

authd_port=""
remoted_port=""
run_in_tcp=""

while [ -n "$1" ]
do
    case $1 in
    "-d"|"-debug")
        debug="-d $debug"
        shift 1
        ;;
    "-dd"|"--ddebug")
        debug="-dd"
        shift 1
        ;;
    "--tcp"|"-t")
        run_in_tcp="1"
        shift 1
        ;;
    "--remotedp"|"-r")
        remoted_port=$2
        shift 2
        ;;
    "--authdp")
        authd_port=$2
        shift 2
        ;;
    *)
        echo "Unknown parameter: $1"
        shift 1
    esac
done

if [ "$run_in_tcp" != "" ]
then
    sed -i "s-<protocol>udp</protocol>-<protocol>tcp</protocol>-g" $DIRECTORY/etc/ossec.conf
fi

if [ "$remoted_port" != "" ]
then
    sed -i "s-<port>1514</port>-<port>$remoted_port</port>-g" $DIRECTORY/etc/ossec.conf
fi

if [ "$authd_port" != "" ]
then
    sed -i "s-<port>1515</port>-<port>$authd_port</port>-g" $DIRECTORY/etc/ossec.conf
fi

$DIRECTORY/bin/wazuh-db $debug
$DIRECTORY/bin/ossec-execd $debug
$DIRECTORY/bin/ossec-analysisd $debug
$DIRECTORY/bin/ossec-remoted $debug
$DIRECTORY/bin/ossec-monitord $debug
$DIRECTORY/bin/ossec-authd $debug
$DIRECTORY/bin/wazuh-modulesd $debug
$DIRECTORY/bin/ossec-logcollector $debug
$DIRECTORY/bin/ossec-syscheckd $debug

tail -F $DIRECTORY/logs/ossec.log
