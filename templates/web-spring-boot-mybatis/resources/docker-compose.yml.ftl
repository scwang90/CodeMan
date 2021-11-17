# yaml docker-compose
version: '3'
services:
  ${projectName}:
    image: openjdk:11
    working_dir: /app
    command: java -jar app.jar
    container_name: ${projectName}
    network_mode: 'host'
    volumes:
      - ./app:/app
    environment:
      TZ: Asia/Shanghai