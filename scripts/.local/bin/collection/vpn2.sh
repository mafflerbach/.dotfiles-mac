#!/bin/bash
cableInterface="enp0s13f0u1u4"
wifiInterface="wlp0s20f3"

wireConnecton=$(nmcli device status | grep "$cableInterface" | cut -d' ' -f14 | head -n1)
wifiConnecton=$(nmcli device status | grep "$wifiInterface" | cut -d' ' -f17 | head -n1)

while :; do
    case "$1" in
        -c) 

            tmux kill-session -t VPN
            if [ "$wifiConnecton" == "connected" ] && [ "$wireConnecton" == "connected" ]; then
                echo "disable wifi"
                nmcli device disconnect "$wifiInterface"
            fi

            # activate wifi if i am not on cable
            if [ "$wifiConnecton" == "disconnected" ] && [ "$wireConnecton" == "disconnected" ]; then
                nmcli device connect "$wifiInterface"
            fi
            # get passwords and usernames
            sysPass=$(pass show Privat/system | head -n1)
            pass=$(pass show Sixt/cato | head -n1)
            user=$(pass show Sixt/cato | tail -n1)

            # create new tmux session named VPN and establish vpn connection
            sleep 2
            cd /opt/cato/; 
            tmux new-session -d -s "VPN"   cato_cclient start 
            # tmux new-session -d -s "VPN"  sudo cato_client --user "$user" --account sixt-rac --password="$pass"

            sleep 1
            send root password to system auth
            tmux send-keys -t "VPN:0" $sysPass Enter
            ;;
        -k) 
            # reactivate wifi connection for the case, that i want to detach from my docking station later
            if [ "$wifiConnecton" == "no" ]; then
                nmcli device connect "$wifiInterface"
            fi

            sysPass=$(pass show Privat/system | head -n1)
            cd /opt/cato/; 
            tmux new-session -d -s "XXXXXX"   cato_cclient stop
            sleep 2
            tmux send-keys -t "XXXXXX:0" $sysPass Enter
            kill tmux session with vpn connection process
            sleep 2
            tmux kill-session -t XXXXXX
            tmux kill-session -t VPN

            ;;
        *)
            break
    esac
    shift
done


