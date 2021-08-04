#!/bin/bash
cableInterface="enp0s31f6"
wifiInterface="wlp3s0"

wireConnecton=$(ethtool "$cableInterface" | grep Link | cut -d' ' -f3)
wifiConnecton=$(ethtool "$wifiInterface" | grep Link | cut -d' ' -f3)

while :; do
    case "$1" in
        -c) 

            tmux kill-session -t VPN
            if [ "$wifiConnecton" == "yes" ] && [ "$wireConnecton" == "yes" ]; then
                echo "disable wifi"
                nmcli device disconnect "$wifiInterface"
            fi

            # activate wifi if i am not on cable
            if [ "$wifiConnecton" == "no" ] && [ "$wireConnecton" == "no" ]; then
                nmcli device connect "$wifiInterface"
            fi
            # get passwords and usernames
            sysPass=$(pass show Privat/system | head -n1)
            pass=$(pass show Sixt/m9338 | head -n1)
            user=$(pass show Sixt/m9338 | tail -n1)

            # create new tmux session named VPN and establish vpn connection
            sleep 2
            tmux new-session -d -s "VPN"  sudo /usr/bin/openfortivpn -c /etc/openfortivpn/config -u "$user"  -p "$pass"
            sleep 1
            # send root password to system auth
            tmux send-keys -t "VPN:0" $sysPass Enter
            ;;
        -k) 
            # reactivate wifi connection for the case, that i want to detach from my docking station later
            if [ "$wifiConnecton" == "no" ]; then
                 nmcli device connect "$wifiInterface"
            fi

            sysPass=$(pass show Privat/system | head -n1)
            tmux new-session -d -s "XXXXXX"  sudo killall openfortivpn
            sleep 2
            tmux send-keys -t "XXXXXX:0" $sysPass Enter
            # kill tmux session with vpn connection process
            sleep 2
            tmux kill-session -t XXXXXX
            tmux kill-session -t VPN

            ;;
        *)
            break
    esac
    shift
done


