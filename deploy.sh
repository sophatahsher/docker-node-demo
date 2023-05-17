#!/bin/bash
DATE=`date +%Y.%m.%d.%H.%M`

echo "build the docker image at $DATE"
sudo docker build . tag docker-app-demo:0.0.1
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
sudo docker run -p 8181:8080 --name docker-node-demo -d docker-app-demo:0.0.1
echo "Deploying the container"