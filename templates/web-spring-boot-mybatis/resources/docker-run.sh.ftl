#!/bin/bash
APP='app.jar'
IMAGE='openjdk:11'
APP_PORT=8080
CONTAINER_PORT=8080
CONTAINER_NAME='${projectName}'
WD="$(cd $(dirname $0);pwd)"
CMD="echo nothing to run!"

exists=$(docker ps -a | grep $CONTAINER_NAME)

if [ -n "$exists" ]; then

        starting=$(docker ps | grep $CONTAINER_NAME)

        if [ -n "$starting" ]; then
                CMD="docker restart $CONTAINER_NAME"
        else
                CMD="docker start $CONTAINER_NAME"
        fi
else
        CMD="docker run -d --name $CONTAINER_NAME -v $WD:/app -p $CONTAINER_PORT:$APP_PORT $IMAGE /bin/bash -c 'cd /app && java -jar $APP'"

fi

echo $CMD
eval $CMD