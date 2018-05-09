#/bin/bash


masterip=$(sudo docker exec s-1 redis-cli -p 26379 sentinel get-master-addr-by-name mymaster | head -n 1)

if [ "${masterip}" == "172.48.0.10" ]; then
    container="redis-m1"
elif [ "${masterip}" == "172.48.0.11" ]; then
    container="redis-r1"
elif [ "${masterip}" == "172.48.0.12" ]; then
    container="redis-r2"
else
    echo "master ip error, please check configure file."
fi

echo 'Current master is'
sudo docker exec s-1 redis-cli -p 26379 sentinel get-master-addr-by-name mymaster

echo 'Stop redis master'
sudo docker pause $container
echo 'Wait 5 seconds.....'
sleep 5

echo 'Current master is'
sudo docker exec s-1 redis-cli -p 26379 sentinel get-master-addr-by-name mymaster

echo 'Restart origin master....'
sudo docker unpause $container
echo 'Wait 5 seconds....'
sleep 5

echo 'Current master is'
sudo docker exec s-1 redis-cli -p 26379 sentinel get-master-addr-by-name mymaster
