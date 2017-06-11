
while [ 1 ]
do
    rsync -rP --append --rsh="/usr/bin/sshpass -p gratis235813 ssh -o StrictHostKeyChecking=no -l pi" marand.dk:/media/pi/Martin1/martin/downloads/ ~/transfers/
    if [ "$?" = "0" ] ; then
        echo "rsync completed normally"
        exit
    else
        echo "Rsync failure. Backing off and retrying..."
        sleep 30
    fi
done
