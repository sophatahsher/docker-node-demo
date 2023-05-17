#!/bin/bash
DATE=`date +%Y.%m.%d.%H.%M`
username=<git username>
password=<password>
DIR=!/Desktop/docker/helloworld
FILE=/home/sivasaisagar/output
container_name=docker-node-demo
if [ -d "$DIR" ];
then
printf '%s\n' "helloworld dir ($DIR)"
rm -rf "$DIR"
else
echo "now no helloworld a dir"
fi
echo "cloning a helloworld dir"
sudo git clone https://<username>:<password>@github.com/sophatahsher/docker-node-demo.git
result=$( sudo docker images -q docker-node-demo )
if [[ -n "$result" ]]; then
echo "image exists"
sudo docker rmi -f docker-node-demo
else
echo "No such image"
fi
echo "change the dir"

echo "delete output file"
cd /home/sher/docker-node-demo/


echo "build the docker image at $DATE"
sudo docker build -t docker-node-demo/sivasai:$DATE . >> /home/sher/output
echo "built docker images and proceeding to delete existing container"
result=$( docker ps -q -f name=docker-node-demo )
if [[ $? -eq 0 ]]; then
echo "Container exists"
sudo docker container rm -f docker-node-demo
echo "Deleted the existing docker container"
else
echo "No such container"
fi

echo "Deploying the updated container at $DATE"
sudo docker run -itd -p 8181:8080 --name docker-node-demo $OUTPUT
echo "Deploying the container"