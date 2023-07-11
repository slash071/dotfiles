#!/bin/bash
# Tarvis (Terminal Jarvis)

set -e
theHour=$(date '+%H')
tellMe=$(date '+%a %b %e \033[0;34m%H:%M\033[0m')

tarvis_breath () {
	if [[ ${theHour#0} -ge 05 ]] && [[ ${theHour#0} -lt 12 ]]; then
		printf "\033[0;33m  \033[0mGood Morning sir, \nIt's $tellMe\n"
	elif [[ ${theHour#0} -ge 12 ]] && [[ ${theHour#0} -lt 17 ]]; then
		printf "\033[0;33m \033[0mGood Afternoon sir, \nIt's $tellMe\n"
	elif [[ ${theHour#0} -ge 17 ]] && [[ ${theHour#0} -lt 21 ]]; then
		printf "\033[0;34m \033[0mGood Evening sir, \nIt's $tellMe\n"
	else
		printf "\033[0;34m \033[0mGoodnight sir, \nIt's $tellMe\n"
        if [[ ${theHour#0} -ge 00 ]] && [[ ${theHour#0} -lt 05 ]]; then
            printf "Sir, it's \e[1mpast 12\e[0m, maybe you should get some rest...\033[0;36m鈴\033[0m\n"
        fi
	fi
}

# Starting Tarvis
tarvis_breath
