#!/bin/bash
# 本脚本需要拷贝到服务器中，在服务器上运行自动部署
# 本脚本依赖于 docker 和 docker-compose 需要在服务器上提前安装好
# ├── ${projectName}
# │   ├── app
# │   │    ├── application.properties
# │   ├── auto-deploy.sh
# │   ├── docker-compose.yml
# │   └── packages
# │        ├── ${projectName}-1.0.0.jar

dir=$(cd $(dirname $0);pwd)
app=$(ls "$dir/packages/" -lt | egrep '.jar$' | head -n 1 | awk '{print $9}')
cmd="cp $dir/packages/$app $dir/app/app.jar"

echo $cmd
eval $cmd

cd $dir

docker-compose down
docker-compose up -d