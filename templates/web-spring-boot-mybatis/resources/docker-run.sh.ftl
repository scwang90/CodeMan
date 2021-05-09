#!/bin/bash
APP_NAME=app.jar
IMAGE_NAME=openjdk:11
CONTAINER_PORT=8080
CONTAINER_NAME=${projectName}

exists=${r"$"}(docker ps -a | grep $CONTAINER_NAME)

if [ -n "$exists" ]; then

        running=${r"$"}(docker ps | grep $CONTAINER_NAME)

        if [ -n "$running" ]; then
                docker restart $CONTAINER_NAME
                echo "docker restart $CONTAINER_NAME"
        else
                docker start $CONTAINER_NAME
                echo "docker start $CONTAINER_NAME"
        fi

else
        docker run -d --name $CONTAINER_NAME -p $CONTAINER_PORT:$CONTAINER_PORT -v ${r"$"}(pwd):/app $IMAGE_NAME /bin/bash -c "cd /app && java -jar ${r"$"}(APP_NAME)"
        echo "docker run -d --name $CONTAINER_NAME -p $CONTAINER_PORT:$CONTAINER_PORT -v ${r"$"}(pwd):/app $IMAGE_NAME /bin/bash -c 'cd /app && java -jar ${r"$"}(APP_NAME)'"

fi