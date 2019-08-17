#!/bin/bash

. /etc/ossec-init.conf

manager_ip="unknown_manager"
authd_port=1515
authd_addr=""
manager_port=""
run_in_tcp=""

while [ -n "$1" ]
do
    case $1 in
    "--manager"|"-m")
        manager_ip=$2
        shift 2
        ;;
    "--authd_server")
        authd_addr=$2
        shift 2
        ;;
    "--managerp"|"-p")
        manager_port=$2
        shift 2
        ;;
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
      "--authdp")
          authd_port=$2
          shift 2
          ;;
    *)
        echo "Unknown parameter: $1"
        shift 1
    esac
done

sed -i "s=<address>.*</address>=<address>$manager_ip</address>=g" $DIRECTORY/etc/ossec.conf

if [ "$run_in_tcp" != "" ]
then
    sed -i "s-<protocol>udp</protocol>-<protocol>tcp</protocol>-g" $DIRECTORY/etc/ossec.conf
fi

if [ "$manager_port" != "" ]
then
    sed -i "s-<port>1514</port>-<port>$manager_port</port>-g" $DIRECTORY/etc/ossec.conf
fi

if [ "$authd_addr" = "" ]
then
  authd_addr=$manager_ip
fi

$DIRECTORY/bin/agent-auth -m $authd_addr -p $authd_port
$DIRECTORY/bin/ossec-execd $debug
$DIRECTORY/bin/ossec-agentd $debug
$DIRECTORY/bin/ossec-syscheckd $debug
$DIRECTORY/bin/ossec-logcollector $debug
$DIRECTORY/bin/wazuh-modulesd $debug

tail -F $DIRECTORY/logs/ossec.log
