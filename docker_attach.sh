#!/bin/bash

function need_dependence {
    if [ "$(which $1)" = "" ];
    then
        echo -e "The script could not be executed. Failure to find the \e[31m\e[1m\e[5m$1 command."
        exit 1
    fi
}

function check_dependencies {
    need_dependence docker
    need_dependence whiptail
    need_dependence awk
    need_dependence cut
    need_dependence nsenter
}

if [ "$(id -u)" != "0" ]; then
   echo "You have to be root to run this script"
   exit 1
fi

check_dependencies

i=0
while read LINE;
do
    CONT_ARRAY[$i]=$LINE
    CONT_ARRAY[$i + 1]=" "
    i=$[ $i + 2 ]
done < <(docker ps |  awk -F '[[:space:]][[:space:]]+' '{if(NR>1)  print $1, " ", $2, " ", $5, " ", $NF}')

CONTAINER=$(whiptail --title "Interface launcher" --menu "Select a container" 16 78 10 "${CONT_ARRAY[@]}" 3>&2 2>&1 1>&3 | cut -d " " -f 1)

if [ "$CONTAINER" = "" ]; then
    echo "No container has been entered."
    exit 0
fi

echo "Entering..."
nsenter --target $(docker inspect --format {{.State.Pid}} $CONTAINER) --moun --uts --ipc --net --pid

exit 0
